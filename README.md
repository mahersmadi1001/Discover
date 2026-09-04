# Discover

## 📱 Project Overview

Discover is a modern, feature-rich e-commerce mobile application built with Flutter. It provides a seamless shopping experience with user authentication, product browsing, cart management, favorites, and more. The app leverages Firebase for authentication and analytics, Hive for local data persistence, and follows MVVM Architecture with BLoC state management.

## 📸 Screenshots





## 🛠 Tech Stack & Architecture

### Core Technologies

| Technology | Purpose |
| --- | --- |
| **Flutter** | UI Framework |
| **Dart** | Programming Language |
| **Firebase Core** | Firebase Integration |
| **Firebase Auth** | Authentication |
| **Google Sign-In** | OAuth Authentication |
| **Firebase Analytics** | User Analytics |

### State Management & Architecture

| Library | Purpose |
| --- | --- |
| **Flutter BLoC** | State Management |
| **Equatable** | Object Comparison |
| **Get It** | Dependency Injection |

### Data Persistence & Networking

| Library | Purpose |
| --- | --- |
| **Hive & Hive Flutter** | Local Key-Value & Object Database |
| **Dio** | HTTP Client for REST APIs |
| **Shared Preferences** | Key-Value Storage for App Settings |

---

## ✨ Features List

### 🔐 Authentication

* **Email/Password Sign Up** - Create new accounts with email verification
* **Email/Password Login** - Secure authentication with Firebase
* **Google Sign-In** - OAuth integration for quick access
* **Account Switching** - Support for multiple Google accounts
* **Session Management** - Persistent login state with auto-restore
* **User Profile** - Store and display user information

### 🛍 Product Management

* **Product Browsing** - Grid view with responsive design
* **Product Details** - Detailed view with images, prices, and descriptions
* **Search Functionality** - Real-time local search with filtering
* **Category Filtering** - Browse products by categories
* **Image Caching** - Optimized image loading with CachedNetworkImage

### ❤️ Favorites System

* **Add to Favorites** - Save products for later
* **User-Specific Favorites** - Each user has their own favorites list
* **Quick Toggle** - One-tap add/remove from favorites
* **Favorites View** - Dedicated screen for saved items
* **Persistent Storage** - Favorites saved locally with Hive

### 🛒 Shopping Cart

* **Add to Cart** - Add products with quantity management
* **Cart Management** - Update quantities, remove items
* **User-Specific Cart** - Isolated cart data per user
* **Price Calculation** - Real-time total price computation
* **Checkout Flow** - Confirmation dialog before purchase
* **Persistent Storage** - Cart data saved locally

### 👤 User Profile

* **Profile Display** - Show user name, email, and avatar
* **Account Settings** - Access to account management options
* **Logout** - Secure sign-out with data cleanup
* **User Data Storage** - User information stored in Hive

### 🎨 UI/UX Features

* **Responsive Design** - Adaptive layouts using ScreenUtil
* **Smooth Animations** - Flutter Animate for transitions
* **Modern UI** - Clean, contemporary design with Material Design
* **Bottom Navigation** - Easy navigation between sections
* **Loading States** - Proper loading indicators
* **Error Handling** - User-friendly error messages

### 📊 Analytics

* **Firebase Analytics** - Track user interactions
* **Event Tracking** - Monitor cart views, product interactions
* **Session Analytics** - User session data collection

---

## 🚀 Setup & Run

### Prerequisites

* **Flutter SDK** - [Install Flutter](https://docs.flutter.dev/get-started/install)
* **Dart SDK** - Included with Flutter
* **Android Studio / Xcode** - For mobile development
* **Firebase Account** - For authentication and analytics

### Environment Setup

1. **Clone the repository**
```bash
git clone <repository-url>
cd discover

```


2. **Install dependencies**
```bash
flutter pub get

```


3. **Generate Hive adapters**
```bash
dart run build_runner build --delete-conflicting-outputs

```


4. **Firebase Configuration**
* Create a new project in [Firebase Console](https://console.firebase.google.com/)
* Add Android app with package name: `com.example.discover`
* Add iOS app with bundle ID: `com.example.discover`
* Download `google-services.json` for Android and place in `android/app/`
* Download `GoogleService-Info.plist` for iOS and place in `ios/Runner/`
* Enable Authentication:
* Email/Password sign-in
* Google Sign-in


* Enable Analytics



### Running the App

**Development / Debug Mode:**

```bash
flutter run

```

**Android Release Build:**

```bash
# APK
flutter build apk --release

# App Bundle
flutter build appbundle --release

```

**iOS Release Build:**

```bash
flutter build ios --release

```

---

## 🔧 Key Implementation Details

### User-Specific Data Storage

The application implements user-specific data isolation using Hive:

* **User Info**: Stored in `users` box with `userId` as key.
* **Cart Data**: Each user has a dedicated `cart_{userId}` box.
* **Favorites**: Each user has a dedicated `favorites_{userId}` box.
* **Automatic Cleanup**: Local session data cleared securely on sign-out.

### Authentication Flow

1. **Sign Up/Login** → Firebase Auth → Save User Info to Hive.
2. **Google Sign-In** → OAuth → Firebase Auth → Save User Info.
3. **Session Check** → Firebase Auth State → Auto-login.
4. **Sign Out** → Firebase Signout → Google Disconnect → Clear Local Data.

**Built with ❤️ using Flutter**

```