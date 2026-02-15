<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

# tt_database

A small shared package that provides local database utilities for the workspace. The package wraps Sembast (or another local store) with helpers used by the app and feature
packages.

## Quick start

Add the package as a path dependency (handled by Melos workspace):

```yaml
dependencies:
  tt_database:
    path: ../../packages/tt_database
```

Basic usage example (informational snippet; adjust to the package API):

```text
import 'package:tt_database/tt_database.dart';

// Example usage (pseudo-code)
final db = await TTDatabase.open('app.db');
await db.put('key', value);
final v = await db.get('key');
```

Check `lib/` for the exact API exported by this package.

## Code generation

This package does not require code generation by default. If you add models that use `freezed` or `json_serializable`, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Contributing

- Update the package API in `lib/`.
- Add tests under `test/`.
- Run `melos bootstrap` to refresh workspace links.

## License

MIT License

Maintainers: Maintainers
