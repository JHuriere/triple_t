# game_data

Data layer for the Game feature. Contains repository implementations, data sources, and DTOs used by the domain and presentation layers.

## Quick start

This package is linked via the workspace. Bootstrap from the repo root:

```bash
melos bootstrap
```

## Project structure

```
lib/
├── datasource/     # Local/remote data sources
├── models/         # DTOs and serialization helpers
└── repository/     # Repository implementations
```

## Usage

Domain defines repository interfaces in `game_domain`. Implementations live here and are wired by the app or feature providers. Check `lib/` for the available types and providers.

## Code generation

If you add `freezed` or `json_serializable` models, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Contributing

Follow the workspace contributing guidelines in the root `README.md`.

## License

MIT License

Maintainers: Maintainers
