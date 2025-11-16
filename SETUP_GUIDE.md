# Setup Guide for Flutter Weather App

## Prerequisites Installation

### 1. Install Flutter SDK

1. **Download Flutter**:
   - Go to https://flutter.dev/docs/get-started/install/windows
   - Download the Flutter SDK ZIP file
   - Extract to `C:\src\flutter` (or your preferred location)

2. **Update PATH**:
   - Search for "Environment Variables" in Windows
   - Edit System Environment Variables
   - Add to Path: `C:\src\flutter\bin`

3. **Verify Installation**:
   ```powershell
   flutter doctor
   ```

### 2. Install Android Studio (Required for Android Development)

1. Download from: https://developer.android.com/studio
2. During installation, ensure these are selected:
   - Android SDK
   - Android SDK Platform
   - Android Virtual Device

3. **Configure Android SDK**:
   - Open Android Studio
   - Go to Tools → SDK Manager
   - Install Android SDK (API 34 or latest)
   - Install Android SDK Command-line Tools

### 3. Install Visual Studio Code (Optional but Recommended)

1. Download from: https://code.visualstudio.com/
2. Install Flutter and Dart extensions

## Project Setup

### Step 1: Navigate to Project Directory
```powershell
cd D:\flutter-weather-app\flutter-weather-app
```

### Step 2: Install Dependencies
```powershell
flutter pub get
```

### Step 3: Check Setup
```powershell
flutter doctor -v
```

This will show:
- ✓ Flutter SDK installed
- ✓ Android toolchain
- ✓ Connected devices (emulator or physical device)

### Step 4: Create Android Emulator (if needed)

**Option A - Using Android Studio:**
1. Open Android Studio
2. Tools → Device Manager
3. Create Virtual Device
4. Select a device (e.g., Pixel 6)
5. Download and select a system image (API 34)
6. Finish and start the emulator

**Option B - Using Command Line:**
```powershell
flutter emulators
flutter emulators --launch <emulator_id>
```

### Step 5: Run the App

**On Emulator:**
```powershell
flutter run
```

**On Physical Device:**
1. Enable Developer Options on your Android phone:
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times
2. Enable USB Debugging in Developer Options
3. Connect phone via USB
4. Run:
```powershell
flutter devices
flutter run
```

## Building Release APK

### Debug APK (for testing)
```powershell
flutter build apk --debug
```

### Release APK (for submission)
```powershell
flutter build apk --release
```

APK location: `build\app\outputs\flutter-apk\app-release.apk`

## Project Structure Overview

```
flutter-weather-app/
├── android/                    # Android-specific files
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── AndroidManifest.xml
│   │   │   ├── kotlin/
│   │   │   └── res/
│   │   └── build.gradle
│   └── build.gradle
├── lib/                        # Main Dart code
│   ├── main.dart              # App entry point
│   ├── models/
│   │   └── weather_data.dart  # Data models
│   ├── screens/
│   │   ├── index_input_screen.dart
│   │   ├── dashboard_screen.dart
│   │   ├── history_screen.dart
│   │   └── about_screen.dart
│   └── services/
│       └── weather_service.dart # API & caching logic
├── pubspec.yaml               # Dependencies
└── README.md                  # Project documentation
```

## Common Issues & Solutions

### Issue: "Flutter SDK not found"
**Solution**: Add Flutter to PATH and restart terminal

### Issue: "Android license not accepted"
**Solution**: Run `flutter doctor --android-licenses` and accept all

### Issue: "No devices found"
**Solution**: Start an emulator or connect a physical device

### Issue: "Gradle build failed"
**Solution**: 
```powershell
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Issue: "Unable to connect to network" in emulator
**Solution**: 
- Check emulator has internet access
- Try cold boot: AVD Manager → Cold Boot Now

## Testing the App

### 1. Online Mode Test
1. Launch app
2. Enter student index (e.g., 224139L)
3. Tap "Fetch"
4. Verify:
   - Weather data displayed
   - Coordinates shown (Lat: 7.20, Lon: 83.10)
   - Request URL visible
   - Time and date correct

### 2. Offline Mode Test
1. Get weather data first (online)
2. Enable Airplane Mode on device/emulator
3. Tap "Refresh Data"
4. Verify:
   - Error message shown
   - Cached data displayed
   - "(cached)" tag visible

### 3. Navigation Test
1. Navigate to History screen
2. Check weather history table
3. Navigate to About Us
4. Check coordinate calculation info
5. Tap Logout → returns to index input

## Creating Deliverables

### 1. Project ZIP
```powershell
# From parent directory
cd D:\flutter-weather-app
Compress-Archive -Path flutter-weather-app -DestinationPath project_224139L.zip
```

Exclude unnecessary files:
- .git folder
- .idea folder
- build folder
- .dart_tool folder

### 2. Screenshots for Report
Capture:
1. Index input screen with index entered
2. Dashboard with full URL visible
3. Dashboard showing "(cached)" tag
4. Error message when offline
5. History screen
6. About Us screen

### 3. Video Recording (≤60 seconds)
Use screen recording:
- **Windows**: Win + G (Game Bar)
- **Android**: Built-in screen recorder
- **OBS Studio**: Free screen recording software

Script:
1. (5s) Show index input, enter index
2. (5s) Tap Fetch, wait for loading
3. (15s) Show dashboard with weather data, scroll to show URL
4. (10s) Navigate to About Us, show coordinates
5. (10s) Enable airplane mode
6. (10s) Tap Refresh, show error and cached tag
7. (5s) Show history screen

## Report Template

### Page 1
**Student Index**: 224139L

**Coordinate Calculation**:
- Formula: lat = 5 + (22/10), lon = 79 + (41/10)
- Calculated Coordinates: Latitude 7.20, Longitude 83.10

**Screenshots**:
- [Screenshot 1: Index Input]
- [Screenshot 2: Dashboard with URL]

### Page 2
**Screenshots (continued)**:
- [Screenshot 3: Cached Data]
- [Screenshot 4: Offline Error]

**Reflection** (3-5 sentences):
"This project helped me understand Flutter app development, including API integration, state management, and offline-first architecture. I learned to handle asynchronous operations, implement local caching with SharedPreferences, and create a responsive multi-screen UI. The most challenging aspect was error handling and ensuring smooth user experience in both online and offline modes. Overall, the project provided valuable hands-on experience with mobile development and REST API consumption."

## Additional Resources

- Flutter Documentation: https://flutter.dev/docs
- Open-Meteo API Docs: https://open-meteo.com/en/docs
- Dart Language Tour: https://dart.dev/guides/language/language-tour
- SharedPreferences: https://pub.dev/packages/shared_preferences
- HTTP Package: https://pub.dev/packages/http

## Support

If you encounter issues:
1. Check Flutter doctor: `flutter doctor -v`
2. Clean and rebuild: `flutter clean && flutter pub get`
3. Check device connection: `flutter devices`
4. Review error logs in terminal
5. Check Android Studio logcat for detailed errors
