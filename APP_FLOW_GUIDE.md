# App Flow & Screen Guide

## 📱 Application Flow Diagram

```
┌─────────────────────┐
│  Index Input Screen │ (Entry Point)
│    (SkyWatch)       │
└──────────┬──────────┘
           │
           │ User enters index
           │ Taps "Fetch"
           ▼
    ┌──────────────┐
    │  API Call    │
    │  (Loading)   │
    └──────┬───────┘
           │
    ┌──────┴────────┐
    │               │
    ▼               ▼
  SUCCESS         ERROR
    │               │
    │               └──> Show error
    │                   Try cache
    ▼
┌─────────────────────┐
│  Dashboard Screen   │ ◄──┐
│                     │    │
│ - Weather Data      │    │
│ - Coordinates       │    │
│ - Request URL       │    │
│ - Refresh Button    │    │
└─────┬───────────────┘    │
      │                    │
      │ Bottom Navigation  │
      │                    │
   ┌──┴──┬──────┬─────┐   │
   │     │      │     │   │
   ▼     ▼      ▼     │   │
┌────┐ ┌────┐ ┌────┐ │   │
│Dash│ │Hist│ │Abou│ │   │
│brd │ │ory │ │t Us│ │   │
└─┬──┘ └──┬─┘ └──┬─┘ │   │
  │       │      │   │   │
  └───────┴──────┴───┘   │
                          │
  Logout ─────────────────┘
```

## 🖼️ Screen Details

### 1️⃣ Index Input Screen
**File**: `lib/screens/index_input_screen.dart`

**Elements**:
```
┌─────────────────────────────┐
│         ☀️ (Sun Icon)        │
│                             │
│        SkyWatch  ☁️         │
│                             │
│   Enter your index to       │
│   calculate your            │
│   personalized location     │
│   coordinates.              │
│                             │
│  Student Index Number :     │
│  ┌───────────────────────┐  │
│  │ e.g., 224139L         │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │       Fetch           │  │
│  └───────────────────────┘  │
└─────────────────────────────┘
```

**Functionality**:
- Input validation (not empty, at least 4 digits)
- Loading indicator on button during fetch
- Error message display
- Navigation to Dashboard on success

**Code Highlights**:
```dart
TextField(controller: _indexController) // Input field
ElevatedButton(onPressed: _fetchWeather) // Fetch button
CircularProgressIndicator() // Loading state
Navigator.pushReplacement() // Navigate to dashboard
```

---

### 2️⃣ Dashboard Screen
**File**: `lib/screens/dashboard_screen.dart`

**Elements**:
```
┌─────────────────────────────┐
│ Dashboard            ⎋      │
├─────────────────────────────┤
│                             │
│ Location & Request Details  │
│ ────────────────────────    │
│ Index-Derived Location:     │
│ Lat: 7.20, Lon: 83.10       │
│                             │
│ Last Updated Time:          │
│ 2:53:55 PM                  │
│                             │
│ Last Updated Date:          │
│ 21/11/2025                  │
│                             │
│ Exact REST Request URL:     │
│ https://api.open-meteo...   │
│                             │
├─────────────────────────────┤
│                             │
│ Current Weather   [Refresh] │
│ ────────────────────────    │
│         ☀️                  │
│       34°C (cached)         │
│    Scorching Sun            │
│                             │
│  🌡️ 34°C        💨 6.2 m/s │
│  Temperature    Wind Speed  │
│                             │
│  🗜️ 1014 hPa    💧 84%     │
│  Pressure       Humidity    │
│                             │
├─────────────────────────────┤
│ 📊  📜  ℹ️                  │
│ Dash Hist About             │
└─────────────────────────────┘
```

**Functionality**:
- Display all weather data
- Show coordinates (2 decimals)
- Display full request URL (selectable)
- Refresh button to fetch new data
- "(cached)" tag when showing offline data
- Bottom navigation to other screens

**Code Highlights**:
```dart
Text('${_weatherData.latitude.toStringAsFixed(2)}') // Coordinates
SelectableText(_weatherData.requestUrl) // URL display
if (_weatherData.isCached) // Cached tag
ElevatedButton.icon(onPressed: _refreshWeather) // Refresh
BottomNavigationBar // Navigation
```

---

### 3️⃣ History Screen
**File**: `lib/screens/history_screen.dart`

**Elements**:
```
┌─────────────────────────────┐
│ ← History            ⎋      │
├─────────────────────────────┤
│                             │
│ Weather History             │
│ ────────────────────────    │
│                             │
│ Time  Date  Desc  Temp ...  │
│ ───────────────────────────│
│ 2:53  21/11 Sun   34  6.2  │
│ 1:20  21/11 Cloud 28  5.1  │
│ ...                         │
│                             │
├─────────────────────────────┤
│ 📊  📜  ℹ️                  │
│ Dash Hist About             │
└─────────────────────────────┘
```

**Functionality**:
- Load history from SharedPreferences
- Display in table format
- Show time, date, description, temp, wind, pressure, humidity
- Scrollable for multiple entries
- Empty state message if no history

**Code Highlights**:
```dart
WeatherService.getHistory() // Load from storage
ListView with table rows // Display history
DateFormat('h:mm a') // Time formatting
DateFormat('dd/MM/yyyy') // Date formatting
```

---

### 4️⃣ About Us Screen
**File**: `lib/screens/about_screen.dart`

**Elements**:
```
┌─────────────────────────────┐
│ ← About Us           ⎋      │
├─────────────────────────────┤
│                             │
│ Purpose                     │
│ ────────────────────────    │
│ This mobile app displays    │
│ the current weather for a   │
│ location computed using     │
│ 224139L index number...     │
│                             │
│ How Coordinates Are         │
│ Generated                   │
│ ────────────────────────    │
│ Latitude = 5 + (first       │
│   two digits of index)/10   │
│ Longitude = 79 + (next      │
│   two digits of index)/10   │
│                             │
│ For My index (224139L)      │
│ ────────────────────────    │
│ Latitude: 7.20              │
│ Longitude: 83.10            │
│                             │
│ API Information             │
│ ────────────────────────    │
│ Current Weather Endpoint:   │
│ https://api.open-meteo...   │
│                             │
├─────────────────────────────┤
│ 📊  📜  ℹ️                  │
│ Dash Hist About             │
└─────────────────────────────┘
```

**Functionality**:
- Display app purpose
- Show coordinate calculation formula
- Display user's specific coordinates
- Show API endpoint information
- All text is readable and properly formatted

**Code Highlights**:
```dart
Text('Latitude: ${latitude.toStringAsFixed(2)}')
SelectableText(apiUrl) // API URL
Card widgets for sections
```

---

## 🔄 Data Flow

### API Call Flow
```
User Input (Index)
    ↓
Calculate Coordinates
    ↓
Build API URL
    ↓
HTTP GET Request
    ↓
┌─────────┴─────────┐
│                   │
Success           Error
│                   │
Parse JSON         │
│                   │
Create WeatherData │
│                   │
Save to Cache      │
│                   │
Add to History     │
│                   ↓
└──────────→ Try Load Cache
                   │
            Display Data
```

### State Management
```
StatefulWidget
    ↓
initState()
    ↓
setState() ← User Action
    ↓
rebuild()
    ↓
UI Updates
```

## 💾 Data Storage

### SharedPreferences Keys
```dart
'cached_weather_data'  // Last successful weather result
'weather_history'      // Array of past weather queries
```

### Data Models
```dart
WeatherData {
  - temperature: double
  - windSpeed: double
  - weatherCode: int
  - lastUpdated: DateTime
  - studentIndex: String
  - latitude: double
  - longitude: double
  - requestUrl: String
  - isCached: bool
}
```

## 🎨 UI Components Used

### Material Widgets
- `Scaffold` - Screen structure
- `AppBar` - Top bar with title
- `Card` - Elevated containers
- `TextField` - Text input
- `ElevatedButton` - Primary buttons
- `CircularProgressIndicator` - Loading
- `BottomNavigationBar` - Bottom nav
- `Icon` - Icons throughout
- `SnackBar` - Toast messages

### Layout Widgets
- `Column` - Vertical layout
- `Row` - Horizontal layout
- `Container` - Box model
- `Padding` - Spacing
- `SizedBox` - Fixed spacing
- `Expanded` - Flexible sizing
- `SingleChildScrollView` - Scrolling

## 🎯 Coordinate Calculation Examples

```
Index: 224139L
First two digits: 22
Next two digits: 41
Latitude  = 5 + (22 / 10) = 5 + 2.2 = 7.20
Longitude = 79 + (41 / 10) = 79 + 4.1 = 83.10
```

```
Index: 194174B
First two digits: 19
Next two digits: 41
Latitude  = 5 + (19 / 10) = 5 + 1.9 = 6.90
Longitude = 79 + (41 / 10) = 79 + 4.1 = 83.10
```

```
Index: 205060A
First two digits: 20
Next two digits: 50
Latitude  = 5 + (20 / 10) = 5 + 2.0 = 7.00
Longitude = 79 + (50 / 10) = 79 + 5.0 = 84.00
```

## 🌐 API Request Example

**Request:**
```
GET https://api.open-meteo.com/v1/forecast?latitude=7.2&longitude=83.1&current_weather=true
```

**Response:**
```json
{
  "latitude": 7.2,
  "longitude": 83.1,
  "current_weather": {
    "temperature": 34.0,
    "windspeed": 6.2,
    "weathercode": 0,
    "time": "2025-11-21T14:53"
  }
}
```

## 🎬 User Journey

1. **Launch App** → Index Input Screen
2. **Enter Index** → Type student number
3. **Tap Fetch** → See loading indicator
4. **API Call** → Fetch weather data
5. **View Dashboard** → See weather + details
6. **Tap Refresh** → Update weather
7. **View History** → See past queries
8. **View About** → Learn about app
9. **Tap Logout** → Return to index input

## 🔌 Offline Behavior

### Scenario 1: First Use Offline
```
1. User enters index
2. Tap Fetch
3. API call fails
4. No cached data available
5. Show error: "Failed to fetch weather data..."
```

### Scenario 2: Use After Previous Success
```
1. User has used app before (online)
2. Enable airplane mode
3. Tap Fetch/Refresh
4. API call fails
5. Load cached data
6. Show "(cached)" tag
7. Display last successful result
```

## 📱 Device Compatibility

- **Minimum SDK**: Android 21 (Lollipop 5.0)
- **Target SDK**: Android 34 (Latest)
- **Orientation**: Portrait (recommended)
- **Screen Sizes**: All supported
- **Internet**: Required for first use

## ⚡ Performance Notes

- **App Size**: ~15-20 MB (release)
- **Startup Time**: < 3 seconds
- **API Response**: 1-3 seconds (depends on network)
- **Offline Load**: Instant (from cache)
- **Memory Usage**: ~50-100 MB

---

**This guide provides a comprehensive overview of how the app works, what each screen does, and how data flows through the application.**
