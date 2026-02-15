# tt_i18n

Localization utilities and generated translations used by the Triple T workspace.

This package contains localization setup, ARB resources (or generation hooks), and helpers to load translated strings in the app and packages.

## Quick start

From the workspace root, generate localization resources (if the project uses `flutter_localizations`/`intl` or custom generation):

```bash
# Example: run the l10n generator via melos
melos run generate:l10n
```

Include this package as a dependency in the app or feature packages using a path dependency configured by Melos (workspace):

```yaml
dependencies:
  tt_i18n:
    path: ../../packages/tt_i18n
```

## Usage

Import the generated localization class and use it in widgets (example shown as plain text to avoid README linting tools interpreting it as runnable code):

```text
// Example
final l10n = AppLocalizations.of(context);
Text(l10n.welcome);
```

Adjust the example above to match the generated API (check `lib/l10n.dart` or `lib/src`).

## Code generation

If translations are generated, run the workspace l10n generator or the specific package generator:

```bash
melos run generate:l10n
# or
dart run build_runner build --delete-conflicting-outputs
```

## Contributing

- Add new strings to the ARB or source file used for localization.
- Run the generation command and update snapshots/tests if any.

## License

MIT License

Maintainers: Maintainers
