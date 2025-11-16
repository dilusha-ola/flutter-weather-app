import 'package:flutter/material.dart';

class WeatherData {
  final double temperature;
  final double windSpeed;
  final int weatherCode;
  final DateTime lastUpdated;
  final String studentIndex;
  final double latitude;
  final double longitude;
  final String requestUrl;
  final bool isCached;

  WeatherData({
    required this.temperature,
    required this.windSpeed,
    required this.weatherCode,
    required this.lastUpdated,
    required this.studentIndex,
    required this.latitude,
    required this.longitude,
    required this.requestUrl,
    this.isCached = false,
  });

  String get weatherDescription {
    // WMO Weather interpretation codes (from Open-Meteo API)
    switch (weatherCode) {
      case 0:
        return 'Clear Sky';
      case 1:
        return 'Mainly Clear';
      case 2:
        return 'Partly Cloudy';
      case 3:
        return 'Overcast';
      case 45:
      case 48:
        return 'Fog';
      case 51:
      case 53:
      case 55:
        return 'Drizzle';
      case 56:
      case 57:
        return 'Freezing Drizzle';
      case 61:
        return 'Light Rain';
      case 63:
        return 'Moderate Rain';
      case 65:
        return 'Heavy Rain';
      case 66:
      case 67:
        return 'Freezing Rain';
      case 71:
        return 'Light Snow';
      case 73:
        return 'Moderate Snow';
      case 75:
        return 'Heavy Snow';
      case 77:
        return 'Snow Grains';
      case 80:
      case 81:
      case 82:
        return 'Rain Showers';
      case 85:
      case 86:
        return 'Snow Showers';
      case 95:
        return 'Thunderstorm';
      case 96:
      case 99:
        return 'Thunderstorm with Hail';
      default:
        return 'Unknown (Code: $weatherCode)';
    }
  }

  IconData get weatherIcon {
    // Return appropriate icon based on weather code
    switch (weatherCode) {
      case 0:
        return Icons.wb_sunny; // Clear sky
      case 1:
      case 2:
        return Icons.wb_sunny_outlined; // Mainly clear / Partly cloudy
      case 3:
        return Icons.cloud; // Overcast
      case 45:
      case 48:
        return Icons.foggy; // Fog
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
        return Icons.grain; // Drizzle
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
      case 80:
      case 81:
      case 82:
        return Icons.umbrella; // Rain
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return Icons.ac_unit; // Snow
      case 95:
      case 96:
      case 99:
        return Icons.thunderstorm; // Thunderstorm
      default:
        return Icons.help_outline; // Unknown
    }
  }

  Color get weatherIconColor {
    // Return appropriate color based on weather code
    switch (weatherCode) {
      case 0:
      case 1:
      case 2:
        return Colors.orange.shade400; // Clear/Sunny
      case 3:
      case 45:
      case 48:
        return Colors.grey.shade600; // Cloudy/Fog
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
      case 80:
      case 81:
      case 82:
        return Colors.blue.shade600; // Rain
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return Colors.lightBlue.shade200; // Snow
      case 95:
      case 96:
      case 99:
        return Colors.purple.shade700; // Thunderstorm
      default:
        return Colors.grey; // Unknown
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'windSpeed': windSpeed,
      'weatherCode': weatherCode,
      'lastUpdated': lastUpdated.toIso8601String(),
      'studentIndex': studentIndex,
      'latitude': latitude,
      'longitude': longitude,
      'requestUrl': requestUrl,
    };
  }

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['temperature'],
      windSpeed: json['windSpeed'],
      weatherCode: json['weatherCode'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      studentIndex: json['studentIndex'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      requestUrl: json['requestUrl'],
    );
  }
}

class WeatherHistoryItem {
  final DateTime time;
  final String date;
  final String description;
  final double temperature;
  final double windSpeed;
  final int pressure;
  final int humidity;

  WeatherHistoryItem({
    required this.time,
    required this.date,
    required this.description,
    required this.temperature,
    required this.windSpeed,
    required this.pressure,
    required this.humidity,
  });
}
