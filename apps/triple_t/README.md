# Triple T

A Flutter application using Riverpod for state management and GoRouter for navigation. The app follows Clean Architecture principles and is organized to keep presentation, domain,
and data logic separated.

## Quick start

Prerequisites

- Flutter SDK compatible with the project (check `sdk` in `pubspec.yaml`)
- Dart SDK (installed with Flutter)

Install dependencies

```bash
# From the app folder
cd apps/triple_t
flutter pub get
```

Run the application

```bash
flutter run
# or select a target device/IDE and run from there
```

## Code generation

This project uses `build_runner` and several code generators (Freezed, json_serializable, Riverpod codegen, etc.).

Common commands:

```bash
# One-time generation
dart run build_runner build --delete-conflicting-outputs

# Watch mode during development
dart run build_runner watch --delete-conflicting-outputs

# Clean generated files
dart run build_runner clean
```

Tip: Use Melos from the workspace root to run generators across all packages: `melos run generate:all`.

## Technologies

- Flutter
- Riverpod (hooks_riverpod)
- GoRouter
- Freezed + json_serializable
- build_runner
- Sembast (local NoSQL)
- Confetti (animation)

## Project structure (high level)

```
apps/triple_t/
├── lib/
│   ├── main.dart            # app entry point
│   ├── presentation/        # UI, pages, providers
│   ├── domain/              # models and use cases
│   └── data/                # repositories and data sources
├── assets/                  # images, icons
├── android/
└── ios/
```

## Development tips

- Keep presentation code dependent only on domain interfaces.
- Run `build_runner` after editing classes annotated with `@freezed` or `@JsonSerializable()`.
- Use `flutter analyze` and `flutter test` regularly.

## Testing

Run tests from the `apps/triple_t` directory:

```bash
flutter test
```

Or run tests for a specific package with Melos from the workspace root.

## Native assets

iOS launch images are located in `ios/Runner/Assets.xcassets/LaunchImage.imageset` and can be replaced if you want custom launch images.

## Contributing

Please follow workspace contribution guidelines in the root `README.md`.

## License

MIT License

Maintainers: Maintainers
