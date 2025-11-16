import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';
import '../screens/history_screen.dart';
import '../screens/about_screen.dart';
import '../services/weather_service.dart';
import '../models/weather_data.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final String studentIndex;
  final double? latitude;
  final double? longitude;
  final WeatherData? weatherData;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.studentIndex,
    this.latitude,
    this.longitude,
    this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: (index) => _handleNavigation(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'About Us',
        ),
      ],
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    // Don't navigate if already on the selected screen
    if (index == currentIndex) return;

    switch (index) {
      case 0: // Dashboard
        if (currentIndex != 0) {
          // Pop back to dashboard if weatherData exists
          if (weatherData != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardScreen(weatherData: weatherData!),
              ),
            );
          } else {
            Navigator.pop(context);
          }
        }
        break;

      case 1: // History
        if (currentIndex != 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HistoryScreen(studentIndex: studentIndex),
            ),
          );
        }
        break;

      case 2: // About Us
        if (currentIndex != 2) {
          final coords = _getCoordinates();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AboutScreen(
                studentIndex: studentIndex,
                latitude: coords['latitude']!,
                longitude: coords['longitude']!,
              ),
            ),
          );
        }
        break;
    }
  }

  Map<String, double> _getCoordinates() {
    // Use provided coordinates if available
    if (latitude != null && longitude != null) {
      return {'latitude': latitude!, 'longitude': longitude!};
    }

    // Otherwise calculate from student index
    try {
      return WeatherService.calculateCoordinates(studentIndex);
    } catch (e) {
      // Return default coordinates if calculation fails
      return {'latitude': 0.0, 'longitude': 0.0};
    }
  }
}
