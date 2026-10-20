# 🌌 Flutter Clean Architecture Template

A production-grade, highly scalable cross-platform Flutter starting architecture. This project uses a **decoupled data-parsing layer** and a **centralized design token ecosystem** to achieve predictable layout rendering without runtime data crashes.

---

## 📁 1. Project Directory Anatomy

Your workspace is structured into isolated layers to prevent leakage between UI layout shells and background business logic:

```text
lib/
├── core/
│   ├── models/
│   │   └── user_model.dart       # 🛡️ Strict Type Boundaries (Normalizes external raw JSON data)
│   ├── network/
│   │   ├── api_service.dart      # 🔌 Dynamic HTTP request infrastructure (Powered by Dio)
│   │   └── user_repository.dart  # 📦 Isolated endpoints with integrated hardcoded fallback data
│   ├── state/
│   │   └── app_state.dart        # 🌐 Centralized Global Context shared state & tracking engine
│   └── theme/
│       └── app_theme.dart        # 🎨 The "CSS" Design Token Sheet (Centralized app coloring matrix)
├── screens/
│   ├── home_screen.dart          # 📱 Layout View: Strictly handles data presentation
│   ├── loading_screen.dart       # ⏳ Reusable loading frame (Enforces smooth UI transition rules)
│   ├── settings_screen.dart      # ⚙️ Layout View: Settings configuration interface
│   └── splash_screen.dart        # 🏁 System initialization startup overlay view
├── widgets/
│   ├── common_text.dart          # 🧩 Atomic reusable presentation text widget
│   └── main_layout.dart          # 🗺️ Core Shell Frame (Manages active bottom nav index switching)
├── app_entry.dart                # 🎛️ Router Switchboard: Evaluates global flags to swap top views
└── main.dart                     # 🚀 Engine Bootstrap: Injects global Provider context models
```

---

## 💻 2. Local Development CLI Commands

Keep this list of essential commands handy while working locally:

### Device Management & App Running
* `flutter devices` — Lists all connected physical phones, web browsers, and active emulators.
* `flutter run -d chrome` — Launches your app inside Google Chrome for rapid UI check cycles.
* `flutter run -d android` — Compiles and deploys directly to a running Android emulator or USB device.
* `flutter run -d ios` — Compiles and deploys to a local macOS iOS Simulator.
* `flutter run -d all` — Launches your application on every available connected platform concurrently.

### Active Session Controls
* `r` — **Hot Reloads** code changes instantly without destroying your active view context state.
* `R` — **Hot Restarts** the application to rebuild global state parameters from scratch.
* `h` — Displays full help documentation directly inside your active terminal console.
* `q` — Stops the hosting server wrapper and quits the run session cleanly.

### System Diagnostics & Project Quality
* `flutter doctor` — Scans system dependencies to verify Android, iOS, and Web SDK tool configurations.
* `flutter analyze` — Performs compiler linting checks to catch typing bugs, overflows, or broken imports.
* `flutter test` — Runs automated script suites located inside your `test/` directory.
* `flutter clean` — Deletes your local build cache folders. Run this immediately if files show phantom bugs.

### Dependency Management
* `flutter pub add [package_name]` — Downloads and anchors a specific package dependency into your project.
* `flutter pub get` — Pulls down and registers all third-party ecosystem libraries listed in `pubspec.yaml`.
* `flutter pub upgrade` — Upgrades all specified libraries to their newest minor/patch versions safely.

### Build & Compilation Profiles
* `flutter build apk --debug` — Generates an emulator-friendly x86_64 **Android APK build file**.
* `flutter build ios --simulator` — Packages an **iOS Simulator-compatible `.app` profile bundle**.
* `flutter build web` — Compiles your `lib/` directory into a production-ready static deployment web layout folder.

---

## 🎨 3. Styling & Configuration Blueprint

### Managing Colors (Your "CSS" Token Sheet)
Do not use hardcoded hex colors or direct `Colors.anyColor` calls inside your UI views. All tokens are managed globally in `lib/core/theme/app_theme.dart`.

* **To add/modify a color globally:** Update the static tokens inside `AppTheme`.
* **To consume themes safely in screens:**
  ```dart
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  color: Theme.of(context).colorScheme.primary,
  ```

### Switching Strategies: Pure Frontend vs. Backend Fetching
This architecture smoothly accommodates both app configurations:
* **Pure Frontend Mode:** Simply switch off network execution flags inside `UserRepository`. Have your repository method directly return your predefined `fallbackMockData` maps passed through your `UserModel.fromJson()` filtering pipelines. Your UI code stays unchanged.
* **Backend Fetching Mode:** Use `ApiService` to direct network requests to your real production endpoint endpoints. The global context `AppState` handles fetching states, and the repository isolates mapping mechanics out of sight.

---

## 🧪 4. Quality Testing Strategy

### The Engineering Philosophy: What is worth testing?
Don't write unit tests for simple structural frames, standard layouts, or colors that are easier to verify visually with your browser extension.

**Prioritize testing your system's data validation gates:**
1. **Type-Safe Data Models:** Ensure that if an API unexpectedly returns missing fields, null entries, or broken objects, your `UserModel.fromJson` mapping schema intercepts them gracefully and supplies fallback defaults instead of crashing your app's UI thread.
2. **Global Switchboard Routing Logic:** Test that changing state flags inside `AppState` successfully triggers view mutations from `SplashScreen` to `MainLayout`.

### Custom Test Suite Execution
To add custom validation scripts alongside your default testing frameworks, create explicit files inside your `test/` directory ending in `_test.dart` (e.g., `test/user_model_test.dart`).

Run all system validations using:
```bash
flutter test
```

---

## 5. Environment Variable Configuration (.env)

This project handles environment configuration profiles using the `flutter_dotenv` ecosystem wrapper.

### 1. File Setup
Create a file named exactly `.env` directly in your root workspace path (next to your `pubspec.yaml` manifest):
```env
API_BASE_URL=https://typicode.com
APP_DEBUG_MODE=true
```

### 2. Assets Registration
Ensure the asset engine references the file path inside your `pubspec.yaml` manifest file rules:
```yaml
flutter:
  assets:
    - .env
```

### 3. Consumption in Code
Extract key mappings anywhere inside your network configuration or state business logic layers like this:
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String targetUrl = dotenv.env['API_BASE_URL'] ?? 'https://domain.com';
```

> ⚠️ **Security Notice:** Compiled `.env` configurations are packaged directly within client binaries. Never store internal administrative credentials, server database passwords, or private production payment keys inside this profile. Keep those isolated safely on your backend server.
---

## 📱 6. Cloud Emulator Builds & Appetize.io

To push and view a native mobile build onto a virtual browser device inside [Appetize.io Platforms](https://docs.appetize.io/ "Appetize Cloud Platform Docs"), execute the appropriate command for the platform you want to verify:

### 🤖 Android Setup (Windows / macOS)
1. **Compile your binary:** Run the following command in your root directory:
   ```bash
   flutter build apk --debug
   ```
2. **Locate your file:** Retrieve the generated package from:
   `build/app/outputs/flutter-apk/app-debug.apk`
3. **Upload to Cloud:** Log into your [Appetize.io App Portal](https://appetize.io/apps "Appetize App Upload Console") and drop that `.apk` file into the upload window.

### 🍏 iOS Setup (Requires macOS & Xcode)
1. **Compile your binary:** Run the following command in your terminal:
   ```bash
   flutter build ios --simulator
   ```
2. **Zip the build:** Compress the generated simulator package from your build folder:
   ```bash
   cd build/ios/iphonesimulator
   zip -r app.zip MindForgeApp.app
   ```
3. **Upload to Cloud:** Drop that newly generated `app.zip` archive directly into the [Appetize App Upload Console](https://appetize.io/apps "Appetize App Upload Console").

---

## 🚀 7. Production App Store Submission Framework (2026 Standards)

Once your application is fully validated via cloud emulation testing, follow these deployment steps to submit your apps to the official stores:

### 🤖 Google Play Console Checklist
Before your app can go live on the Google Play Store, you must navigate Google's verified publishing gate rules:

* **Account Requirement:** Register an official Google Play Developer Profile (requires a $25 one-time developer registration fee).
* **🚨 Personal Account Testing Guard:** If your account was created after November 13, 2023, you **cannot publish straight to production**. You must run a mandatory **Closed Testing Track** using at least **12 verified testers** who must remain opted-in and actively testing for **14 consecutive calendar days**.
* **Production Build Step:** Compile your signed target deployment bundle:
  ```bash
  flutter build appbundle --release
  ```
  This creates an `app-release.aab` bundle file. Upload this asset directly inside your Play Console under your production track.

### 🍏 Apple App Store Connect Checklist
Publishing on the iOS App Store requires a macOS environment running updated Xcode software tools:

* **Account Requirement:** Enroll in the Apple Developer Program (requires a $99 annual subscription fee).
* **SDK Compilation Minimum Rule:** As of April 2026, all applications uploaded to App Store Connect **must be compiled with Xcode 26 or later**, matching target requirements running the **iOS 26 SDK or higher**.
* **Production Build Step:** Run your archiving configuration sequence command:
  ```bash
  flutter build ipa --release
  ```
  This generates a target `.ipa` asset file bundle. Open your Transporter app tool or use Xcode's direct upload integration interface to push this completed release archive asset straight up into your [App Store Connect Workspace](https://developer.apple.com/app-store/submitting/ "Apple App Store Connect Submission Rules") portal.

### 📋 Mandatory Pre-Submission Asset Materials
Ensure your marketing and product configuration documents contain these fully filled out items:

1. Live Privacy Policy URL: An external public webpage hosting your official application privacy statements.
2. App Store Screenshots: A minimum of 2 high-resolution screenshots for each supported target layout screen factor size (e.g., iPhone 6.7" display vs. iPad views).
3. Data Safety / Privacy Nutrition Questionnaire Labels: Complete your data tracking collection compliance disclosures before pushing the build for review.
