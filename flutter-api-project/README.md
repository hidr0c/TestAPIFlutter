# Flutter API Project

This project is a Flutter application that displays data from various gaming APIs. It includes a user interface that allows users to view and filter games based on different criteria such as method, description, and API value.

## Project Structure

```
flutter-api-project
├── lib
│   ├── main.dart                # Entry point of the application
│   ├── models
│   │   └── game_model.dart      # Defines the GameModel class
│   ├── services
│   │   └── api_service.dart      # Handles API requests
│   ├── screens
│   │   ├── home_screen.dart      # Main user interface
│   │   └── game_details_screen.dart # Displays detailed game information
│   ├── widgets
│   │   ├── game_card.dart        # Represents a single game in the list
│   │   └── filter_widget.dart     # Allows users to filter games
├── pubspec.yaml                  # Project configuration and dependencies
└── README.md                     # Project documentation
```

## Features

- Displays a list of games retrieved from APIs.
- Allows users to filter games based on various criteria.
- Provides detailed information about each game when selected.

## Setup Instructions

1. Clone the repository:
   ```
   git clone <repository-url>
   ```

2. Navigate to the project directory:
   ```
   cd flutter-api-project
   ```

3. Install the dependencies:
   ```
   flutter pub get
   ```

4. Run the application:
   ```
   flutter run
   ```

## Usage

- Upon launching the app, users will see a list of games.
- Users can use the filter widget to narrow down the list based on their preferences.
- Clicking on a game card will navigate to a detailed view of the selected game.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any suggestions or improvements.