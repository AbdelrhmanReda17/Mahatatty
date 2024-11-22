# Mahatatty 🚉

**Mahatatty** (محطتي) is a cross-platform mobile designed for train booking and ticket reservation. The name "Mahatatty" means "station" in Arabic, and the app offers users an easy and convenient way to search, book, and pay for train tickets. It also provides up-to-date news, weather, and train offers, making it a complete solution for travelers in Egypt.

---

## Documentation

- **Presentation Link:** https://www.canva.com/design/DAGTlUw0nqQ/4VMHph3FlR_aRUJz7I8rzg/view?utm_content=DAGTlUw0nqQ&utm_campaign=designshare&utm_medium=link&utm_source=editor
- **Documnetation Link:** https://github.com/AbdelrhmanReda17/Mahatatty/blob/265f60cf7daf83f133cefca4030b89054ed5803c/Mahatatty%20Documentation.pdf

---

## Features

### Authentication & User Management
- **Sign Up/Login:** Users can sign up using their email, password, and name or log in using Google.
- **Password Reset:** Users who forget their password can reset it via a link sent to their email.
- **Session Management:** User information is stored locally, allowing automatic login on subsequent app launches unless they log out.

### Modes & Themes
- **Dark/Light Mode:** The app supports both dark and light themes for a better user experience in various lighting conditions.

### Booking & Ticketing
- **One-way and Round-trip Options:** Users can choose their trip type, select travel dates, departure and arrival stations, and choose train class.
- **Search & Payment:** After selecting their preferred ticket, users can choose from various payment options to complete the purchase.

### News Section
- **Latest Updates:** The home screen includes a news section featuring the latest updates and announcements.
- **Hot News:** Clicking on a news item opens detailed information, and users can view all hot news on a separate page.
- **News Search:** A search functionality is available to help users find specific news articles.

### Explore Page
- **Best Offers:** Displays the best train offers, user location, current weather, temperature, and more relevant details for travelers.

### My Tickets
- **Booked Tickets:** Users can view and manage their booked tickets on the **My Tickets** page.

### Settings
- **Profile Management:** Users can update their name, password, and logout through the settings page.

---

## Architecture

The app follows a **modular architecture** based on **MVVM (Model-View-ViewModel)** pattern, combined with **Clean Architecture** principles, ensuring high maintainability, scalability, and testability.

### Key Components:
1. **Model:** Handles data representation, including interaction with APIs like Firestore for train schedules and news articles.
2. **View:** The user interface, built using Flutter widgets, reacts to state changes in the ViewModel.
3. **ViewModel:** The intermediary between Model and View, managing the business logic and state updates using **Riverpod** for efficient state management.

### Clean Architecture Layers:
- **Presentation Layer:** Contains View Models and UI components, handling user input and reflecting changes in the state.
- **Domain Layer:** Manages business logic, independent of UI, ensuring flexibility for future modifications.
- **Data Layer:** Manages data operations, fetching information from APIs and local databases.

---

## Backend & Data Management

- **Firebase Firestore:** Real-time database for user authentication, train schedules, and news articles.
- **Shared Preferences:** Lightweight storage for user preferences and application states .
- **RESTful Services:** Interaction with Firebase APIs through asynchronous HTTP requests, ensuring smooth client-server communication.

### Caching & Offline Support
- **Firestore Offline Persistence:** Ensures access to previously loaded data (like news articles) when the device is offline.
- **Shared Preferences Caching:** Stores small, persistent data like user preferences across app sessions.

---

## State Management

The app uses **Riverpod** for managing state across different modules such as **news**, **train booking**, and **authentication**:
- **Scoped State Management:** Each module has its own state, ensuring isolated and efficient updates.
- **Providers and Listeners:** UI components listen to state changes in the ViewModel, automatically updating when data changes.

---

## Modular Approach

The app is divided into multiple modules for different functionalities:
- **Auth:** Handles user login, registration, and password management.
- **News:** Displays news articles and hot news, with search capabilities.
- **Train Booking:** Manages train selection, ticket booking, and payment options.
- **Onboarding:** Guides users through the initial setup.
- **Settings:** Allows users to edit profile and manage application preferences.

---

## Getting Started

### Prerequisites
- Flutter SDK installed (version 2.0 or above).
- Firebase account setup with Firestore enabled.
- IDE (like VSCode or Android Studio) for running the app.

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/AbdelrhmanReda17/mahatatty.git
    ```

2. Navigate to the project directory:
    ```bash
    cd mahatatty
    ```

3. Install dependencies:
    ```bash
    flutter pub get
    ```

4. Set up Firebase by following the instructions to add Firebase configuration files (GoogleService-Info.plist for iOS, google-services.json for Android).

5. Run the app on a connected device or emulator:
    ```bash
    flutter run
    ```

---

## Contact

For any inquiries or support, feel free to contact us via LinkedIn or other professional networks.

---
