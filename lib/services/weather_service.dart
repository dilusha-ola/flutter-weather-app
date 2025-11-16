import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_data.dart';

class WeatherService {
  static const String baseUrl = 'https://api.open-meteo.com/v1/forecast';
  static const String cacheKey = 'cached_weather_data';
  static const String historyKey = 'weather_history';

  // Calculate coordinates from student index
  static Map<String, double> calculateCoordinates(String index) {
    // Extract first two and next two digits
    final cleanIndex = index.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleanIndex.length < 4) {
      throw Exception('Index must contain at least 4 digits');
    }

    final firstTwo = int.parse(cleanIndex.substring(0, 2));
    final nextTwo = int.parse(cleanIndex.substring(2, 4));

    final lat = 5.0 + (firstTwo / 10.0);
    final lon = 79.0 + (nextTwo / 10.0);

    return {'latitude': lat, 'longitude': lon};
  }

  // Build request URL
  static String buildRequestUrl(double lat, double lon) {
    return '$baseUrl?latitude=$lat&longitude=$lon&current_weather=true';
  }

  // Fetch weather data from API
  static Future<WeatherData> fetchWeather(String studentIndex) async {
    try {
      final coords = calculateCoordinates(studentIndex);
      final lat = coords['latitude']!;
      final lon = coords['longitude']!;
      final url = buildRequestUrl(lat, lon);

      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final currentWeather = data['current_weather'];

        final weatherData = WeatherData(
          temperature: currentWeather['temperature'].toDouble(),
          windSpeed: currentWeather['windspeed'].toDouble(),
          weatherCode: currentWeather['weathercode'],
          lastUpdated: DateTime.now(),
          studentIndex: studentIndex,
          latitude: lat,
          longitude: lon,
          requestUrl: url,
        );

        // Cache the successful result
        await cacheWeatherData(weatherData);
        
        // Add to history
        await addToHistory(weatherData);

        return weatherData;
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      // Try to return cached data if available
      final cached = await getCachedWeatherData();
      if (cached != null) {
        return WeatherData(
          temperature: cached.temperature,
          windSpeed: cached.windSpeed,
          weatherCode: cached.weatherCode,
          lastUpdated: cached.lastUpdated,
          studentIndex: cached.studentIndex,
          latitude: cached.latitude,
          longitude: cached.longitude,
          requestUrl: cached.requestUrl,
          isCached: true,
        );
      }
      rethrow;
    }
  }

  // Cache weather data
  static Future<void> cacheWeatherData(WeatherData data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = json.encode(data.toJson());
    await prefs.setString(cacheKey, jsonData);
  }

  // Get cached weather data
  static Future<WeatherData?> getCachedWeatherData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonData = prefs.getString(cacheKey);
      
      if (jsonData != null) {
        final data = json.decode(jsonData);
        return WeatherData.fromJson(data);
      }
    } catch (e) {
      // Ignore cache errors
    }
    return null;
  }

  // Add to history
  static Future<void> addToHistory(WeatherData data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString(historyKey);
      
      List<dynamic> history = [];
      if (historyJson != null) {
        history = json.decode(historyJson);
      }
      
      // Add new entry at the beginning
      history.insert(0, data.toJson());
      
      // Keep only last 20 entries
      if (history.length > 20) {
        history = history.sublist(0, 20);
      }
      
      await prefs.setString(historyKey, json.encode(history));
    } catch (e) {
      // Ignore history errors
    }
  }

  // Get history
  static Future<List<WeatherData>> getHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString(historyKey);
      
      if (historyJson != null) {
        final List<dynamic> history = json.decode(historyJson);
        return history.map((item) => WeatherData.fromJson(item)).toList();
      }
    } catch (e) {
      // Ignore history errors
    }
    return [];
  }
}
