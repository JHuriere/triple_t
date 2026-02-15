# Triple T Workspace

A multi-package Flutter workspace managed with Melos. This repository contains the Triple T application and multiple feature and package libraries following a modular Clean
Architecture approach.

Quick links

- Application: `apps/triple_t`
- Features: `features/`
- Shared packages: `packages/`

## Quick start

Prerequisites

- Flutter (match the project SDK, e.g. 3.10.x)
- Dart SDK compatible with the Flutter version
- Melos (recommended for workspace management)

Install Melos

```bash
dart pub global activate melos
```

Bootstrap the workspace

```bash
# From the repository root
melos bootstrap
# Or run pub get in each package
melos exec -- flutter pub get
```

Run the app

```bash
cd apps/triple_t
flutter run
# Or using melos
melos exec --scope="triple_t" -- flutter run
```

## Common Melos scripts

- melos run generate:all — Run code generation across packages
- melos run generate:l10n — Generate localization files
- melos run clean:deep — Clean generated files and caches
- melos list — List workspace packages

## Architecture

This workspace follows Clean Architecture principles with clear separation of responsibilities:

- Presentation (UI, providers) — `features/*/*_presentation` or `apps/triple_t/lib/presentation`
- Domain (entities, use cases, interfaces) — `features/*/*_domain`
- Data (repositories, data sources) — `features/*/*_data`

The root `pubspec.yaml` contains the workspace configuration used by Melos.

## Development tips

- Use `dart run build_runner build --delete-conflicting-outputs` for one-off code generation.
- Use `dart run build_runner watch --delete-conflicting-outputs` during development for auto-regeneration.
- Run `melos bootstrap` after adding or moving packages.

## Testing

Run tests per package or use melos to run them across the workspace:

```bash
# single package
cd features/settings/settings_presentation
flutter test

# all packages
melos run test
```

## Contributing

1. Create a feature branch.
2. Implement changes and update/add tests.
3. Generate code if required: `melos run generate:all`.
4. Submit a pull request.

## License

This workspace is provided under the MIT License.

Maintainers: Maintainers
