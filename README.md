# Note Application

## Project Overview
This project is a mobile application developed using the Flutter framework, designed to facilitate the management of personal notes. The primary objective of the application is to provide users with a robust and intuitive interface for creating, editing, storing, and organizing text-based notes. Additionally, the application integrates local notification services to support scheduled reminders, ensuring users can set alerts for specific notes.

## Key Features
- **Note Management**: Comprehensive CRUD (Create, Read, Update, Delete) functionality for notes.
- **Local Storage**: Data persistence capabilities using `GetStorage` to ensure notes are saved locally on the device.
- **Scheduled Reminders**: Integration with `flutter_local_notifications` to schedule and deliver system notifications at specified times.
- **Theme Management**: Dynamic light and dark mode switching capabilities.
- **State Management**: Utilization of the GetX package for efficient state management and dependency injection.

## Technical Architecture
The project adheres to a **Feature-First Architecture**, promoting separation of concerns, scalability, and maintainability. The codebase is organized into three primary layers:

### 1. Core Layer (`lib/core/`)
Contains shared resources and utilities accessible throughout the application.
- **Theme**: Application-wide theme definitions and color palettes.
- **Widgets**: Reusable UI components.
- **Constants**: Static constant values used across the project.

### 2. Data Layer (`lib/data/`)
Handles data manipulation and external services.
- **Models**: Data classes defining the structure of application entities (e.g., `NoteModel`).
- **Services**: Services for handling specific functionalities such as notifications (`NotificationService`).

### 3. Features Layer (`lib/features/`)
Encapsulates independent functional modules of the application. Each feature contains its own views and controllers.
- **Home**: The main dashboard displaying the list of notes.
- **Note**: Functionality for viewing, creating, and editing individual notes.
- **Settings**: Configuration options including theme selection.
- **Splash**: Initial launch screen handling loading logic.

## File Structure
The directory structure of the project is organized as follows:

```
lib/
├── core/
│   ├── const/              # Application constants (colors, strings)
│   ├── theme/              # Theme configuration
│   └── widgets/            # Shared UI components
├── data/
│   ├── models/             # Data models (NoteModel)
│   └── services/           # Service classes (NotificationService)
├── features/
│   ├── home/               # Home screen logic and UI
│   ├── note/               # Note editing logic and UI
│   ├── settings/           # Settings logic and UI
│   └── splash/             # Splash screen logic and UI
└── main.dart               # Application entry point
```

## Setup and Installation

### Prerequisites
- Flutter SDK (latest stable version recommended)
- Android Studio or VS Code
- Android SDK (API 35 recommended)

### Installation Steps
1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/your-repo-name.git
    ```

2.  **Navigate to the project directory:**
    ```bash
    cd notes
    ```

3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

4.  **Run the application:**
    ```bash
    flutter run
    ```
