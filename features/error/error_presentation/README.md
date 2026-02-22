# Error Presentation

Flutter package for the presentation layer of the error handling feature in the Triple T application.

## Description

This package is part of Triple T's modular architecture and provides the user interface for handling navigation errors and page not found scenarios.

## Features

- **Error Page**: User-friendly interface to display navigation errors
- **Internationalization**: Multi-language support via `tt_i18n`
- **Navigation**: Integration with `go_router` for error route handling
- **Reactive State**: Uses Riverpod for state management

## Structure

```
lib/
├── error_presentation.dart          # Package entry point
└── src/
    ├── pages/
    │   └── error_page.dart          # Error display page
    └── router/
        ├── router.dart              # Router exports
        └── navigator/
            ├── error_navigator.dart # Navigation interface
            └── get_error_navigator.dart # Riverpod provider
```

## Usage

### Import the package

```dart
import 'package:error_presentation/error_presentation.dart';
```

### Use the error page

The error page is automatically displayed when navigation errors occur:

```dart
ErrorPage
(
error
:
'
Optional error message
'
,
)
```

### Navigate from the error page

The error page provides a button to return to the home page:

```dart
ref.read
(
getErrorNavigatorProvider
)
.
goHome
(
context
);
```

## Dependencies

- `flutter`: Flutter framework
- `hooks_riverpod`: State management
- `go_router`: Navigation
- `tt_i18n`: Internationalization (local package)

## Development

### Tests

```bash
flutter test
```

### Code Generation

This package uses `build_runner` and `riverpod_generator`:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Architecture

This package follows Clean Architecture principles:

- **Presentation**: Widgets and UI logic only
- **Isolation**: No dependencies on data or domain layers
- **Reusability**: Can be used in different contexts within the application
