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
    // WMO Weather interpretation codes
    switch (weatherCode) {
      case 0:
        return 'Clear Sky';
      case 1:
      case 2:
      case 3:
        return 'Partly Cloudy';
      case 45:
      case 48:
        return 'Foggy';
      case 51:
      case 53:
      case 55:
        return 'Drizzle';
      case 61:
      case 63:
      case 65:
        return 'Rain';
      case 71:
      case 73:
      case 75:
        return 'Snow';
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
        if (weatherCode >= 0 && weatherCode <= 10) {
          return 'Scorching Sun';
        }
        return 'Unknown';
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
