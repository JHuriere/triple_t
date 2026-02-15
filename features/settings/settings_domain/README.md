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

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart

const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.

# settings_domain

Domain layer for the Settings feature. Contains business models, use cases, and repository interfaces.

## Quick start

This package contains the domain contracts used by presentation and data layers. To develop, bootstrap the workspace with Melos:

```bash
melos bootstrap
```

## Project structure

```
lib/
├── model/          # Domain models
├── use_case/       # Use cases and business rules
└── repository/     # Abstract repository interfaces
```

## Usage

Implementations of the repository interfaces live in `settings_data`. Presentation uses the domain package to call use cases.

## Testing

Write unit tests for use cases and domain logic. Domain should not import Flutter dependencies.

## License

MIT License

Maintainers: Maintainers
