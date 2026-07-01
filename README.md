# Tatva 26

Tatva 26 is a Flutter mobile app for the Tatva festival experience. It brings together event listings, live updates, sports and cultural sections, announcements, timelines, sponsors, and in-app Firebase-powered notifications.

## Features

- Festival home screen with hero banner and announcements
- Bottom navigation for Home, Cultural, Live, Sports, and Timeline
- Event browsing for cultural and sports activities
- Live events section
- Timeline view for schedule-based navigation
- Sponsors and about sections
- Firebase Authentication and Firebase Messaging integration
- Local notification support
- Custom theme, fonts, and reusable UI components
- Contact actions such as phone calls and email links

## Tech Stack

- Flutter
- GetX for state management and navigation
- Firebase Core
- Firebase Authentication
- Firebase Cloud Messaging
- Flutter Local Notifications
- Google Sign-In
- Dio for network requests
- URL Launcher
- Permission Handler
- Google Fonts

## Project Structure (Strict GetX Pattern)

- `lib/main.dart` — app entry point and Firebase initialization
- `lib/app/routes/` — GetX named routing configuration (`app_pages.dart` & `app_routes.dart`)
- `lib/app/core/theme/` — theme, colors, and size constants
- `lib/app/core/values/` — app-wide constants
- `lib/app/data/` — data layer containing models and services
- `lib/app/global_widgets/` — reusable UI widgets shared across multiple modules
- `lib/app/modules/` — independent feature modules (e.g., home, splash, event, timeline), each containing their own `bindings`, `controllers`, and `views`
- `assets/` — images and fonts used across the app

## Available Routes

With the GetX pattern migration, the app uses named routing. The available routes defined in `Routes` are:
- `/splash` - Splash Screen
- `/bottom-nav` - Main Bottom Navigation
- `/home` - Home Screen
- `/event` - Cultural Events 
- `/sports-event` - Sports Events
- `/timeline` - Timeline/Schedule
- `/profile` - Student Profile
- `/aboutus` - About Us
- `/sponsors` - Sponsors
- `/announcements` - All Announcements

## Prerequisites

- Flutter SDK `^3.7.0`
- Dart SDK compatible with the Flutter version above
- Android Studio, Xcode, or VS Code for development
- Firebase project configured for the app

## Download

You can install **Tatva 26** using one of the following options:

### Google Play Store (Recommended)

> **Note:** The app is currently available to members of the Tatva Google Group.

1. Join the [Google Group](https://groups.google.com/g/tatva26)
   <img src="assets/images/googlegroup_ss.jpeg" width="300" />
2. Download the app from [Google Play Store](https://play.google.com/store/apps/details?id=com.nitp.festapp)
   <img src="assets/images/playstore_ss.jpeg" width="300" />

### APK

If you are unable to access the Play Store version, download the APK directly:

-[Download APK](https://drive.google.com/drive/folders/1q1WzZw0KC0LhPlNMFUerAMsDl-rkZ4cg)
