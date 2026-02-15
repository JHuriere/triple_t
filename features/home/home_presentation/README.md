# home_presentation

Presentation layer for the Home feature. Contains UI widgets, pages, and Riverpod providers used by the home screens.

## Quick start

This package is part of the workspace and is referenced as a path dependency by the app. To develop locally use Melos from the workspace root:

```bash
melos bootstrap
melos exec --scope="home_presentation" -- flutter run
```

## Project structure

```
lib/
├── pages/         # Screen widgets
├── widgets/       # Reusable UI components
└── providers/     # Riverpod providers
```

## Usage

Import the presentation package into the app or other presentation packages if needed:

```dart
import 'package:home_presentation/home_presentation.dart';
```

Then use provided widgets and providers inside your app UI.

## Code generation

If this package uses code generation (freezed/json_serializable), run the workspace generation commands:

```bash
melos run generate:all
# or
cd features/home/home_presentation
dart run build_runner build --delete-conflicting-outputs
```

## Contributing

Follow the workspace contributing guidelines at the repository root.

## License

MIT License

Maintainers: Maintainers
