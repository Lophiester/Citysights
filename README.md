
# Citysights App Documentation

## Project Overview
Citysights App is a Swift-based application designed to search for and display local businesses using the Yelp API. The app leverages CoreLocation to access user location, providing location-based recommendations and search results.

## Key Features
- **Business Search**: Fetches businesses from Yelp API based on user location.
- **Location Services**: Utilizes CoreLocation to get the user's current location.
- **Onboarding Flow**: Displays an onboarding screen on first launch, requesting location permissions.
- **MVVM Architecture**: Organized with Model, ViewModel, and Service layers.

---

## Project Structure
```
Citysights App
│
├── CitysightsApp.swift           # Main app entry point
│
├── ViewModel
│   └── BusinessViewModel.swift   # Manages app state, user location, and API calls
│
├── Model
│   └── BusinessModel.swift       # Data models for business, category, and location
│
└── Services
    └── DataService.swift         # Handles API requests and responses
```

---

## Dependencies and Frameworks
- **SwiftUI** – User Interface.
- **CoreLocation** – Location services and permissions.
- **Foundation** – Networking, data models, and system utilities.

---

## Main Components
### 1. CitysightsApp.swift
- Entry point of the app, initializes `BusinessViewModel` as an environment object.
- Manages onboarding logic using `@AppStorage`.

```swift
@main
struct Citysights: App {
    @State var model = BusinessViewModel()
    @AppStorage("onboarding") var needsOnboarding: Bool = true
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(model)
                .fullScreenCover(isPresented: $needsOnboarding) {
                    needsOnboarding = false
                } content: {
                    OnboardingView().environment(model)
                }
        }
    }
}
```

---

### 2. BusinessViewModel.swift
- Observes location changes and manages API calls.
- Requests location permissions and fetches business data asynchronously.

```swift
class BusinessViewModel: NSObject, CLLocationManagerDelegate {
    var businesses = [BusinessModel]()
    var selected: BusinessModel?
    var service = DataService()
    var locationManager = CLLocationManager()
    var locationAuthStatus: CLAuthorizationStatus = .notDetermined

    override init() {
        super.init()
        locationManager.delegate = self
    }
}
```

---

### 3. BusinessModel.swift
- Defines the structure for business objects, including categories and location details.

```swift
struct BusinessModel: Decodable, Identifiable {
    var id: String?
    var name: String?
    var rating: Double?
    var coordinates: Coordinate?
    var categories: [Category]
}
```

---

### 4. DataService.swift
- Makes requests to the Yelp API using `URLSession`.
- Fetches businesses near the user's location.

```swift
struct DataService {
    private let apiKey: String? = Bundle.main.infoDictionary?["API_KEY"] as? String

    func businessSearch(userLocation: CLLocationCoordinate2D?, query: String?) async throws -> [BusinessModel] {
        let urlString = "https://api.yelp.com/v3/businesses/search"
        // Perform request
    }
}
```

---

## Setup and API Integration
- Add your Yelp API key to the app's `Info.plist` under the key `API_KEY`.
- Ensure location permissions are configured in `Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to show nearby businesses.</string>
```

---

## How it Works
1. Onboarding screen prompts for location permission.
2. App fetches user location and makes an API request to Yelp.
3. Results are displayed in a list with details like name, rating, and category.

---

## Future Improvements
- Add caching to reduce API requests.
- Implement error handling for network failures.
- Include additional filters for search queries.

---

## Author
**Charles Yamamoto**  
Created on **November 16, 2024**.  
