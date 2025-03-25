# stepwise
# AI Fitness Tracker - Flutter App

A Flutter application that tracks user steps and provides fitness-related information, with a structure designed for maintainability and potential AI integration.

## Features

* **Step Counter:** Tracks the user's daily step count using the device's pedometer.
* **Distance and Calorie Calculation:** Estimates distance traveled and calories burned based on step count.
* **Permission Handling:** Requests and manages necessary permissions (e.g., activity recognition).
* **Modular Architecture:** Organized codebase with separate services for pedometer, permissions, and notifications.
* **Reusable UI Components:** Includes a custom button widget for consistent UI elements.
* **Splash Screen:** A splash screen is displayed when the app is launched.
* **Local Notifications:** The app displays local notifications, including a daily step reminder.

## Project Structure

The project is structured as follows:

lib/main.dart            # Entry point of the applicationscreens/splash_screen.dart    # Splash screen UIstep_counter_screen.dart # Main screen for step trackingservices/pedometer_service.dart   # Handles pedometer functionalitypermission_service.dart  # Handles permission requestsnotification_service.dart # Handles local notificationsmodels/step_data.dart       # Data model for step information (optional)utils/helper_functions.dart # Utility functionswidgets/custom_button.dart     # Reusable custom button widgetassets/logo.png             # App logo# your_model.tflite    # (Optional) AI model file# your_labels.txt      # (Optional) AI model labels file
## Core Components

* **`main.dart`**:  Initializes the app, sets up services, and defines the main route.
  
* **`screens/splash_screen.dart`**:  Displays a splash screen on app startup and navigates to the main screen.
  
* **`screens/step_counter_screen.dart`**:  Displays step count, calories, and distance.  Requests permissions and interacts with the `PedometerService`.
  
* **`services/pedometer_service.dart`**:  Manages the `pedometer` plugin to get step count data.
  
* **`services/permission_service.dart`**:  Uses the `permission_handler` plugin to request activity recognition permission.
  
* **`services/notification_service.dart`**:  Uses the `flutter_local_notifications` plugin to schedule and display local notifications.
  
* **`models/step_data.dart`**:  (Optional) Defines a data model for step information.
  
* **`utils/helper_functions.dart`**:  Contains helper functions (e.g., for calculations).
  
* **`widgets/custom_button.dart`**:  A reusable custom button widget with customizable appearance.
  
* **`assets/`**:  Contains the app's logo, and optionally, AI model files.

## Getting Started

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/AdityaInamdar334/stepwise.git
    cd stepwise
    ```

2.  **Install Flutter:** Ensure you have the Flutter SDK installed on your system.  See the [official Flutter installation guide](https://flutter.dev/docs/get-started/install).

3.  **Install Dependencies:** Run the following command in your project directory:
    ```bash
    flutter pub get
    ```

4.  **Configure Assets:**
    * Place your app logo (`logo.png`) in the `lib/assets/` folder.
    * If you have an AI model, place the `.tflite` model file and the `.txt` labels file in the `lib/assets/` folder.
    * Update the `pubspec.yaml` file to declare your assets:
        ```yaml
        flutter:
          uses-material-design: true
          assets:
            - lib/assets/logo.png
            # - lib/assets/your_model.tflite  # Uncomment if you have these
            # - lib/assets/your_labels.txt    # Uncomment if you have these
          fonts:
            - family: GoogleSans
              fonts:
                - asset: fonts/GoogleSans-Regular.ttf
        ```

5.  **Run the App:** Run the app on a connected device or emulator:
    ```bash
    flutter run
    ```

##  Next Steps

* **Implement UI:** Design a user-friendly interface for the `StepCounterScreen` and any other screens you add.
* **Add State Management:** Consider using a state management solution (e.g., Provider, Riverpod, or Bloc) for managing app state, especially as you add more features.
* **Integrate AI (Optional):**
    * If you have an AI model, integrate it into the `PedometerService` or a separate service to predict activity or provide fitness insights.  You'll need to add the TensorFlow Lite dependency and load your model.
    * Remember to handle the AI model's input and output appropriately.
* **Data Storage:** Implement local storage (e.g., using shared\_preferences or a database like SQLite) to persist step data, user preferences, and other information.
* **Enhance Features:**
    * Add more fitness-related features, such as:
        * Step history and progress tracking
        * Goal setting
        * More accurate calorie and distance calculations
        * Integration with other fitness sensors
* **Testing:** Write unit and integration tests to ensure the app's functionality and robustness.
* **Error Handling:** Implement comprehensive error handling and user feedback mechanisms.
* **Publish to Play Store:** Prepare your app for release on the Google Play Store, following the store's guidelines.

##  Dependencies

* [pedometer](https://pub.dev/packages/pedometer): For accessing step count data.
* [permission\_handler](https://pub.dev/packages/permission_handler): For handling permission requests.
* [flutter\_local\_notifications](https://pub.dev/packages/flutter_local_notifications): For displaying local notifications.
* [timezone](https://pub.dev/packages/timezone): For handling timezones.
* [google\_fonts](https://pub.dev/packages/google_fonts): For using the Google Sans font.
    #   tflite: ^1.1.2  # For TensorFlow Lite (Add this if you are using AI)....[upcoming feature in progress]

##  Contributions

Contributions are welcome!  Feel free to submit issues and pull requests.
