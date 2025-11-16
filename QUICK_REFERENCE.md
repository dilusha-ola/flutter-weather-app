# Quick Reference - Flutter Weather App Commands

## Essential Commands

### Setup
```powershell
# Install dependencies
flutter pub get

# Check Flutter setup
flutter doctor

# List available devices
flutter devices
```

### Running the App
```powershell
# Run on connected device/emulator
flutter run

# Run in debug mode
flutter run --debug

# Run in release mode
flutter run --release

# Run with hot reload (default)
flutter run
# Then press 'r' to hot reload
# Press 'R' to hot restart
# Press 'q' to quit
```

### Building
```powershell
# Build debug APK
flutter build apk --debug

# Build release APK (for submission)
flutter build apk --release

# Build app bundle (for Play Store)
flutter build appbundle --release
```

### Cleaning
```powershell
# Clean build files
flutter clean

# Clean and get packages
flutter clean ; flutter pub get
```

### Testing
```powershell
# Run tests
flutter test

# Run with verbose logging
flutter run -v
```

## Common Keyboard Shortcuts (While Running)

- **r** - Hot reload (refresh UI instantly)
- **R** - Hot restart (restart app)
- **q** - Quit
- **h** - Help
- **d** - Detach (keep app running)
- **v** - Open DevTools in browser

## Project File Locations

### Source Code
- Main entry: `lib/main.dart`
- Screens: `lib/screens/*.dart`
- Models: `lib/models/weather_data.dart`
- Services: `lib/services/weather_service.dart`

### Configuration
- Dependencies: `pubspec.yaml`
- Android config: `android/app/build.gradle`
- App manifest: `android/app/src/main/AndroidManifest.xml`

### Build Output
- Debug APK: `build/app/outputs/flutter-apk/app-debug.apk`
- Release APK: `build/app/outputs/flutter-apk/app-release.apk`

## Modifying the App

### Change App Name
Edit `android/app/src/main/AndroidManifest.xml`:
```xml
android:label="SkyWatch"
```

### Change Package Name
Edit `android/app/build.gradle`:
```gradle
applicationId "com.example.flutter_weather_app"
```

### Change App Icon
Replace files in `android/app/src/main/res/mipmap-*/ic_launcher.png`

### Add Dependencies
Edit `pubspec.yaml`, then run:
```powershell
flutter pub get
```

## Debugging Tips

### View Logs
```powershell
# View all logs
flutter logs

# Filter logs
flutter logs --device-id=<device_id>
```

### Debug in VS Code
1. Open project in VS Code
2. Press F5 to start debugging
3. Set breakpoints by clicking left of line numbers
4. Use Debug Console for evaluation

### Debug in Android Studio
1. Open project in Android Studio
2. Click Run → Debug 'main.dart'
3. Use Logcat for system logs
4. Use Flutter Inspector for UI debugging

## Quick Fixes

### "Gradle build failed"
```powershell
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### "No devices found"
```powershell
# List emulators
flutter emulators

# Launch emulator
flutter emulators --launch <emulator_id>

# Or start from Android Studio
# Tools → Device Manager → Play button
```

### "Package not found"
```powershell
flutter clean
flutter pub get
flutter pub upgrade
```

### App not updating on device
```powershell
# Force reinstall
flutter run --force-reinstall
```

## Student Index Customization

To use your own index, modify the example in:
`lib/screens/index_input_screen.dart`

```dart
TextField(
  controller: _indexController,
  decoration: InputDecoration(
    hintText: 'e.g., YOUR_INDEX_HERE',
    // ...
  ),
),
```

And update in:
`lib/screens/about_screen.dart` - Purpose section

## Testing Scenarios

### 1. Normal Operation
```
1. Enter index → Tap Fetch
2. View weather data
3. Check coordinates match formula
4. Verify URL is correct
```

### 2. Offline Mode
```
1. Get weather first (online)
2. Enable Airplane Mode
3. Tap Refresh
4. Verify cached data shows
5. Check "(cached)" tag appears
```

### 3. Error Handling
```
1. Enter invalid index (less than 4 digits)
2. Enter empty index
3. Network timeout simulation
```

## Performance Tips

- Use `const` constructors where possible (already done)
- Avoid rebuilding widgets unnecessarily
- Use `ListView.builder` for large lists
- Profile with: `flutter run --profile`

## Creating Release Build

### Step 1: Test thoroughly
```powershell
flutter run --release
```

### Step 2: Build APK
```powershell
flutter build apk --release
```

### Step 3: Locate APK
```
build\app\outputs\flutter-apk\app-release.apk
```

### Step 4: Test on device
```powershell
# Install manually
adb install build/app/outputs/flutter-apk/app-release.apk
```

## Documentation Commands

```powershell
# Generate documentation
dart doc .

# Format code
flutter format lib/

# Analyze code
flutter analyze
```

## Environment Info

```powershell
# Flutter version
flutter --version

# Doctor with verbose
flutter doctor -v

# List connected devices
flutter devices -v
```

## Useful URLs

- Flutter Docs: https://docs.flutter.dev
- Pub.dev (packages): https://pub.dev
- Open-Meteo API: https://open-meteo.com
- Flutter GitHub: https://github.com/flutter/flutter

## Sample Student Indexes for Testing

- 224139L → Lat: 7.20, Lon: 83.10
- 194174B → Lat: 6.90, Lon: 83.10
- 205060A → Lat: 7.00, Lon: 84.00
- 156789X → Lat: 6.50, Lon: 85.70
