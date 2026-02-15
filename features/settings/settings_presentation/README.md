<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing features, see the Dart guide for
[creating features](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing features and plugins](https://flutter.dev/to/develop-packages). 
-->

# settings_presentation

Presentation layer for the Settings feature. Contains UI widgets, pages, and Riverpod providers for settings screens and preferences.

## Quick start

This package is part of the workspace and is referenced by the main app. Use Melos to bootstrap and run the app:

```bash
melos bootstrap
melos exec --scope="settings_presentation" -- flutter run
```

## Project structure

```
lib/
├── pages/         # Settings screens
├── widgets/       # Reusable UI components
└── providers/     # Riverpod providers for settings
```

## Usage

Import and use the UI widgets and providers provided by this package:

```dart
import 'package:settings_presentation/settings_presentation.dart';
```

## Code generation

If generators are used in this package, run:

```bash
melos run generate:all
# or
cd features/settings/settings_presentation
dart run build_runner build --delete-conflicting-outputs
```

## Contributing

Follow the workspace contributing guidelines at the repository root.

## License

MIT License

Maintainers: Maintainers
