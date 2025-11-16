# SkyWatch - Flutter Weather App

## Project Overview
This Flutter application displays personalized weather information based on a student index number. The app calculates location coordinates from the index and fetches real-time weather data from the Open-Meteo API.

## Student Information
**Student Index**: 224139L (Update with your index)

## Calculated Coordinates
Based on the formula:
- Latitude = 5 + (22/10) = 7.20
- Longitude = 79 + (41/10) = 83.10

## Features Implemented

### 1. Index Input Screen
- Text input field for student index number
- Clean, card-based UI design
- Fetch button with loading state
- Error handling for empty input
- Automatic navigation to dashboard on success

### 2. Dashboard Screen
- **Location & Request Details Section**:
  - Index-derived latitude and longitude (2 decimal places)
  - Last updated time (from device clock)
  - Last updated date
  - Full REST API request URL (selectable text)
  
- **Current Weather Section**:
  - Large temperature display in °C
  - Weather description (interpreted from weather code)
  - Weather icon
  - "(cached)" tag when showing offline data
  - Refresh button to fetch new data
  
- **Weather Details Grid**:
  - Temperature with thermometer icon
  - Wind speed with air icon
  - Pressure with compress icon
  - Humidity with water drop icon

### 3. History Screen
- Table view of past weather queries
- Columns: Time, Date, Description, Temperature, Wind, Pressure, Humidity
- Scrollable table for multiple entries
- Stores up to 20 recent queries

### 4. About Screen
- Purpose statement
- Coordinate calculation formula explanation
- User's specific index and calculated coordinates
- API endpoint information

### 5. Technical Features
- **API Integration**: Open-Meteo forecast API
- **Local Caching**: SharedPreferences for offline support
- **Error Handling**: Friendly error messages with fallback to cached data
- **Loading States**: Progress indicators during API calls
- **Navigation**: Bottom navigation bar for easy screen switching
- **Responsive UI**: Works on various screen sizes

## API Details
**Endpoint**: `https://api.open-meteo.com/v1/forecast`

**Parameters**:
- latitude: Calculated from index
- longitude: Calculated from index
- current_weather: true

**Response Data Used**:
- temperature (°C)
- windspeed (m/s)
- weathercode (WMO code)

## Offline Support
The app caches the last successful weather result using SharedPreferences. When offline:
1. Attempts API call
2. On failure, retrieves cached data
3. Displays with "(cached)" tag
4. Shows error message via SnackBar

## How to Run

1. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run on Emulator/Device**:
   ```bash
   flutter run
   ```

3. **Build APK**:
   ```bash
   flutter build apk --release
   ```

## Testing Checklist

### Online Mode
- [x] Enter student index
- [x] Fetch weather data
- [x] Display temperature, wind speed, weather code
- [x] Show calculated coordinates
- [x] Display request URL
- [x] Show last updated time and date
- [x] Refresh button updates data

### Offline Mode
- [x] Enable airplane mode
- [x] Tap Fetch/Refresh
- [x] See friendly error message
- [x] Display cached data with "(cached)" tag

### Navigation
- [x] Dashboard → History
- [x] Dashboard → About Us
- [x] History → Dashboard
- [x] About Us → Dashboard
- [x] Logout returns to index input

## Deliverables Preparation

### 1. Project ZIP
Create `project_224139L.zip` containing the entire Flutter project.

### 2. Report (PDF)
Include:
- Student index: 224139L
- Coordinate formula and calculated values
- Screenshots showing:
  - Index input screen
  - Dashboard with request URL visible
  - Cached data indicator
  - Error handling
- Reflection (3-5 sentences)

### 3. Video Demo (≤60 seconds)
Show:
1. Enter/confirm index → Tap Fetch
2. Display live weather result with URL visible
3. Enable airplane mode
4. Tap Refresh → Show error message
5. Display cached data with "(cached)" tag

## Reflection Points
- Learned Flutter state management and API integration
- Implemented offline-first architecture with caching
- Handled asynchronous operations and error states
- Created responsive UI with multiple screens
- Used coordinate calculation algorithm from index

## Dependencies Used
```yaml
dependencies:
  http: ^1.1.0              # HTTP requests
  shared_preferences: ^2.2.2 # Local storage
  intl: ^0.18.1             # Date/time formatting
```

## Known Issues & Solutions
- **Issue**: API call timeout
  - **Solution**: 10-second timeout with fallback to cache
  
- **Issue**: Network unavailable
  - **Solution**: Error handling with cached data display

## Future Enhancements
- Weather forecast (hourly/daily)
- Multiple location support
- Weather alerts and notifications
- Dark mode theme
- Animated weather icons
