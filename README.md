# Flutter Weather App - SkyWatch

A personalized weather dashboard Flutter application that derives location coordinates from a student index number and displays current weather information using the Open-Meteo API.

## Features

- **Index-Based Location**: Automatically calculates latitude and longitude from your student index
- **Real-time Weather**: Fetches current weather data including temperature, wind speed, pressure, and humidity
- **Offline Support**: Caches last successful result for offline viewing
- **Weather History**: Tracks previous weather queries
- **Clean UI**: Modern, user-friendly interface with multiple screens

## Coordinate Calculation Formula

```
firstTwo  = int(index[0..1])
nextTwo   = int(index[2..3])
latitude  = 5  + (firstTwo / 10.0)
longitude = 79 + (nextTwo / 10.0)
```

Example: For index `224139L`:
- First two digits: 22
- Next two digits: 41
- Latitude: 5 + (22/10) = 7.20
- Longitude: 79 + (41/10) = 83.10

## Screens

1. **Index Input Screen**: Enter your student index number
2. **Dashboard**: View current weather, location details, and request URL
3. **History**: Browse past weather queries
4. **About Us**: Learn about the app and coordinate calculation

## Installation

1. Ensure Flutter is installed on your system
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to launch the app

## Dependencies

- `http`: For API calls to Open-Meteo
- `shared_preferences`: For local caching
- `intl`: For date/time formatting

## API

This app uses the Open-Meteo API (no API key required):
```
https://api.open-meteo.com/v1/forecast?latitude=LAT&longitude=LON&current_weather=true
```

## Building for Release

```bash
flutter build apk --release
```

The APK will be generated in `build/app/outputs/flutter-apk/`

## Requirements Met

✅ Text input for student index  
✅ Computed lat/lon display (2 decimals)  
✅ Fetch Weather button with API call  
✅ Temperature, wind speed, weather code display  
✅ Last updated time from device clock  
✅ Exact request URL displayed on screen  
✅ Loading indicator while fetching  
✅ Error handling with friendly messages  
✅ Offline cache with "(cached)" tag  
✅ Clean UI with proper labels and layout