# 📝 Notes App (Google Drive Sync & Secure Authentication)

A partially feature-rich Flutter application for managing personal notes with robust security, cloud synchronization, and local reminders. Built with **Clean Architecture** and **Feature-First** principles.

## 🚀 Key Features

*   **Google Sign-In**: Secure and seamless authentication using Google accounts.
*   **Google Drive Synchronization**: Backup and restore your notes to/from a private App Folder in your Google Drive.
*   **Local Reminders**: Schedule notifications to remind you of important notes.
*   **Secure Storage**: Sensitive data (tokens) are handled securely, and secrets are excluded from version control.
*   **Localization**: Supports English, Russian, and Uzbek languages.

---

## 🛠️ Project Setup & Installation Guide

**IMPORTANT:** This project relies on sensitive API keys and configuration files that are **NOT** included in the repository for security reasons. You **MUST** generate them yourself to run the app.

### 🚫 Ignored Files (Missing after clone)
The following files are added to `.gitignore` and will **NOT** be present when you clone the repo. You must recreate them:
*   `android/app/google-services.json` (Firebase Config for Android)
*   `ios/Runner/GoogleService-Info.plist` (Firebase Config for iOS)
*   `macos/Runner/GoogleService-Info.plist` (Firebase Config for macOS)
*   `lib/firebase_options.dart` (Firebase Options for Flutter)
*   `lib/core/config/app_secrets.dart` (Google Client ID & Scopes)
*   `android/key.properties` (Keystore credentials for Release build)
*   `ios/Flutter/Config.xcconfig` (Google Sign-In URL Scheme for iOS)

### 📋 Prerequisites

*   Flutter SDK (Latest Stable)
*   Dart SDK
*   A Google Account (for Firebase and Google Cloud Console)

---

### Phase 1: 🔐 Security Configuration (The "Secrets" File)

The app needs a Client ID and specific Scopes to talk to Google. Since we don't commit secrets to Git, you need to create this file manually.

1.  Navigate to `lib/core/config/`.
2.  Create a new file named `app_secrets.dart`.
3.  Copy and paste the code below into the file:

```dart
// File: lib/core/config/app_secrets.dart

class AppSecrets {
  /// CLIENT ID: Get this from your Google Cloud Console (APIs & Services -> Credentials).
  /// It usually looks like "123456789-xxxxxxxx.apps.googleusercontent.com".
  static const String googleClientId = 'YOUR_GOOGLE_CLIENT_ID_HERE';

  /// SCOPES: These are the permissions we need.
  /// 'drive.file' allows the app to ONLY access files created by this app (secure).
  static const List<String> googleScopes = [
    'https://www.googleapis.com/auth/drive.file',
  ];
}
```

> **Note:** We also ignore `lib/firebase_options.dart` to prevent your specific Firebase configuration from leaking. You will generate this in the next step.

---

### Phase 1.5: 🍎 iOS Configuration (Config.xcconfig)

For Google Sign-In to work on iOS, we need to set the `REVERSED_CLIENT_ID` in a way that doesn't expose it in `Info.plist`.

1.  Navigate to `ios/Flutter/`.
2.  Create a new file named `Config.xcconfig`.
3.  Add the following line (replace with your actual REVERSED_CLIENT_ID from GoogleService-Info.plist):

```xcconfig
// File: ios/Flutter/Config.xcconfig
GOOGLE_REVERSED_CLIENT_ID=com.googleusercontent.apps.YOUR_ID_HERE
```
> **Tip:** You can find this ID in `ios/Runner/GoogleService-Info.plist` under the key `REVERSED_CLIENT_ID`.

---

### Phase 2: 🔥 Firebase Setup

To enable Google Sign-In, you need a Firebase project.

1.  Go to the [Firebase Console](https://console.firebase.google.com/).
2.  **Create a New Project** (or use an existing one).
3.  **Enable Authentication**:
    *   Go to **Build** -> **Authentication** -> **Sign-in method**.
    *   Click on **Google**, enable it, and save.
4.  **Register your Android App**:
    *   Go to **Project Settings** (gear icon) -> **General**.
    *   Click the **Android** icon.
    *   **Package Name**: Use `com.example.notes` (or check `android/app/build.gradle`.
    *   **SHA-1 Certificate**: You MUST add your machine's SHA-1 key.
        *   Run this in your terminal: `./gradlew signingReport` (in the `android/` folder).
        *   Copy the `SHA1` from the `debug` variant.
    *   **Download config file**: Download `google-services.json`.
    *   **Move file**: Place `google-services.json` into the `android/app/` directory of your project.

5.  **Generate `firebase_options.dart`** (Optional but Recommended):
    *   If you use the FlutterFire CLI, run: `flutterfire configure`. This will generate `lib/firebase_options.dart` with your project details.

---

### Phase 3: ☁️ Google Cloud & Drive API

For synchronization to work, the Google Drive API must be enabled.

1.  Go to the [Google Cloud Console](https://console.cloud.google.com/).
2.  Make sure your Firebase project is selected in the top bar.
3.  Go to **APIs & Services** -> **Enabled APIs & services**.
4.  Click **+ ENABLE APIS AND SERVICES**.
5.  Search for **Google Drive API** and click **Enable**.
6.  **Configure OAuth Consent Screen**:
    *   Go to **OAuth consent screen**.
    *   Select **External**.
    *   Fill in required fields (App name, email).
    *   **Test Users**: Add your own email address here so you can test the login/sync while the app is in "Testing" mode.

---

### Phase 4: 🏃‍♂️ Running the App

Once you have:
1.  Created `lib/core/config/app_secrets.dart`.
2.  Placed `google-services.json` in `android/app/`.
3.  Enabled Google Drive API.

Run the dependencies command:

```bash
flutter pub get
```

Then run the app:

```bash
flutter run
```

---

## 📂 Project Structure

This project follows a strict **Clean Architecture** to ensure maintainability.

*   **`lib/core/`**: Shared utilities, constants, theme data, and common widgets.
*   **`lib/data/`**:
    *   **`services/`**: logic for external APIs (Google Auth, Drive, Notifications).
    *   **`db/`**: Local database schema (Drift/SQLite).
*   **`lib/features/`**: The main app features (Screens + Controllers).
    *   **`home/`**: Display notes list.
    *   **`note/`**: Create/Edit notes.
    *   **`settings/`**: User profile, Sync settings, Language, Theme.

---

## ⚠️ Troubleshooting

*   **"Auth token unavailable"**: This usually means you haven't added your email to the **Test Users** list in the Google Cloud Console OAuth Consent Screen.
*   **"PlatformException(sign_in_failed, ...)"**: Check that your `google-services.json` is correct and that the SHA-1 fingerprint in Firebase matches your local keystore.
*   **Sync Stuck**: Ensure `drive.file` scope is requested and you have internet access.

---

