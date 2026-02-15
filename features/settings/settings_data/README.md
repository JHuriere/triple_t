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

# settings_data

Data layer for the Settings feature. Implements repositories, local storage, and data mappers used by the Settings domain and presentation layers.

## Quick start

Part of the workspace — bootstrap the workspace to link packages:

```bash
melos bootstrap
```

## Project structure

```
lib/
├── repository/     # Repository implementations
├── datasource/    # Local/remote data sources
└── models/         # DTOs and serialization helpers
```

## Usage

The app or domain layer imports the interfaces from the domain package and uses implementations from this package. Check `lib/` for concrete types and providers.

## Code generation

Run code generators when adding `freezed` or `json_serializable` models:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Contributing

Follow the workspace contributing guidelines at the repository root.

## License

MIT License

Maintainers: Maintainers
