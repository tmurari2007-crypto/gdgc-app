# 🌍 Travel Explorer - GDGC VNRVJIET Mobile App

A clean, modern, and highly polished **Travel Explorer** mobile application built with **Flutter (Dart)** and **Material 3** for the GDGC VNRVJIET App Development Recruitment Assignment.

The app allows users to explore iconic destinations across India, search and filter places dynamically, inspect in-depth travel guides with popular attractions, view real-time live weather, open locations directly in Google Maps, and manage a personalized trip wishlist with offline local persistence.

---

## 📱 Screenshots & Previews

| Destination Discovery | Destination Details | Search & Filtering | Travel Wishlist |
| :---: | :---: | :---: | :---: |
| *(Hero Carousel & Chips)* | *(Live Weather & Map Link)* | *(Instant Live Search)* | *(Persistent Offline Storage)* |

---

## ✨ Features

### 🌟 Core Requirements
1. **Stage 1: Destination Discovery (Home)**
   - Curated list of destinations across India covering 4 categories:
     - 🏖️ **Beaches**: Goa, Andaman & Nicobar
     - 🏔️ **Mountains**: Manali, Shimla, Munnar
     - 🏛️ **Heritage**: Jaipur, Hampi
     - 🧗 **Adventure**: Rishikesh, Auli
   - Vibrant 2-column grid layout with image caching, location pin, category tag, and quick-save heart toggle.
   - Smooth animated Category Chips (*All, Beaches, Mountains, Heritage, Adventure*).

2. **Stage 2: Navigation & Destination Details**
   - Seamless Hero animations transitioning from the card image into the detail header.
   - Rich destination guide: in-depth description, coordinates, and "Best Time to Visit" highlight banner.
   - **Popular Attractions Carousel**: Horizontal gallery of 3 top tourist spots with images and names.
   - Dynamic persistent bottom bar with reactive **Add to Wishlist / Remove from Wishlist** state.

3. **Stage 3: Search & Dynamic Filtering**
   - Live, instant case-insensitive search by destination name or state location.
   - Seamless synergy between search queries and category chips (e.g. searching "Manali" while selecting "Mountains").
   - Friendly empty-state illustrations with one-tap "Reset Filters" action.

4. **Stage 4: Travel Wishlist**
   - Instant state reactivity across all views via `Provider` & `ChangeNotifier`.
   - Dedicated Wishlist screen with clear item list, thumbnail preview, and delete button.
   - **Safety Confirmation Dialog** for "Clear All Wishlist" action.
   - Floating snackbar feedback with action undo support.

---

### 🚀 Extension Challenges (Implemented)
1. 💾 **Local Storage Persistence**:
   - Integrated `shared_preferences` to persist wishlist destination IDs locally on the device.
   - Wishlist seamlessly restores on app restart without any backend requirement.
2. 🗺️ **Google Maps External Navigation**:
   - "Open in Google Maps" button in Destination Details using `url_launcher`.
   - Opens the exact coordinate query (`https://www.google.com/maps/search/?api=1&query=lat,lng`) in the user's default navigation app.
3. ⛅ **Live Real-Time Weather Integration**:
   - Integrated the free **Open-Meteo REST API** (no API key required) using `http`.
   - Dynamically fetches live temperature (°C), weather conditions (e.g., Clear Sky, Fog, Rain, Snow), and wind speeds based on the destination's latitude and longitude.
   - Includes graceful loading indicator, error handling, and manual retry trigger.
4. 🤖 **Smart Destination Matcher**:
   - An intelligent matching screen where travelers select their preferred travel vibe (category), budget tier (*Low, Medium, High*), and maximum trip duration (days).
   - Generates tailored destination suggestions based on ideal stay days and budget attributes.
5. 🌓 **Dark & Light Mode Support**:
   - Custom-crafted Light and Dark themes with Google Font `Poppins`, harmonious teal color palette, and high-contrast night aesthetics.

---

## 🛠️ Architecture & Tech Stack

- **Framework**: Flutter 3 (Dart null-safe)
- **UI Design System**: Material 3 Design with custom travel theme tokens
- **Typography**: Google Fonts (`Poppins`)
- **State Management**: `Provider` (`ChangeNotifierProvider`, `Consumer`, `context.watch/read`)
- **Image Handling**: `cached_network_image` with fallback error and loading placeholders
- **External Launcher**: `url_launcher` for external Google Maps navigation
- **Networking**: `http` for Open-Meteo weather forecasts
- **Local Persistence**: `shared_preferences`

---

## 📂 Project Folder Structure

```text
lib/
├── data/
│   └── destinations_data.dart     # Static list of destinations & attractions across India
├── models/
│   ├── attraction.dart            # Attraction data model (name, imageUrl)
│   └── destination.dart           # Destination data model (id, name, category, budget, etc.)
├── providers/
│   ├── destination_provider.dart  # Manages query, category filter, and smart matcher
│   └── wishlist_provider.dart     # Reactive wishlist state + SharedPreferences persistence
├── screens/
│   ├── details_screen.dart        # Hero image, live weather, attractions, maps link
│   ├── home_screen.dart           # Discovery grid, live search bar, category chips
│   ├── matcher_screen.dart        # Smart Destination Matcher recommendation tool
│   ├── profile_screen.dart        # App info, stats, theme toggle
│   ├── search_screen.dart         # Dedicated search & explore screen
│   └── wishlist_screen.dart       # Saved destinations with delete & clear all
├── utils/
│   ├── constants.dart             # Color tokens, radii, spacing constants
│   ├── theme.dart                 # Custom Material 3 Light & Dark themes
│   └── weather_service.dart       # Free Open-Meteo API integration
├── widgets/
│   ├── attraction_tile.dart       # Horizontal attraction card
│   ├── category_chip.dart         # Smooth animated category selector
│   ├── destination_card.dart      # 2-column grid destination card with heart toggle
│   ├── empty_state_view.dart      # Empty state illustration and action
│   └── weather_card.dart          # Real-time weather card with live API state
└── main.dart                      # App entry point, MultiProvider & Bottom Navigation
```

---

## ⚙️ Setup & Run Instructions

### Prerequisites
- Flutter SDK (`>= 3.0.0`)
- Android Studio / VS Code with Flutter extension
- An Android Emulator, iOS Simulator, or connected physical device

### Installation
1. Clone the repository:
   ```bash
   git clone <your-repository-url>
   cd gdgcapp
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run static analysis:
   ```bash
   flutter analyze
   ```

4. Run unit tests:
   ```bash
   flutter test
   ```

5. Launch the application:
   ```bash
   flutter run
   ```

---

## 🧠 How It Works (State Management & Flow)

### 1. Simple, Clean State Management with Provider
The app separates UI from business logic using two ChangeNotifier providers:
- **`DestinationProvider`**: Holds the static destination repository and maintains the live `_searchQuery` and `_selectedCategory`. The getter `filteredDestinations` applies search and category filters simultaneously, recalculating whenever a user types or selects a chip and calling `notifyListeners()`.
- **`WishlistProvider`**: Stores a `Set<String> _wishlistIds`. Set operations provide $O(1)$ lookup time for checking whether a destination is saved. Any heart icon click invokes `toggleWishlist()`, which automatically saves to `SharedPreferences` and triggers `notifyListeners()`.

### 2. Live Weather Flow
When navigating to `DestinationDetailsScreen`, the embedded `WeatherCard` triggers an asynchronous `http.get` call to the Open-Meteo API with the destination's coordinates. The UI smoothly transitions through:
- **Loading**: Circular progress indicator with descriptive text.
- **Success**: Current temperature (°C), weather condition emoji and text, and wind speed.
- **Error**: Cloud error icon and a one-tap retry button.

---

## 📹 Demo Video Script & Interview Talking Points

*(See accompanying `DEMO_SCRIPT.md` for the full 2–3 minute presentation script and technical interview answers)*
