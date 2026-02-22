# tt_linter

Workspace lint rules and analyzer configuration for the Triple T monorepo. This package centralizes analysis options so all apps and packages share the same defaults.

## Quick start

Add the package as a dev dependency (via the workspace path setup):

```yaml
dev_dependencies:
  tt_linter:
    path: ../../packages/tt_linter
```

Include the shared rules in your `analysis_options.yaml`:

```yaml
include: package:tt_linter/analysis_options.yaml
```

## Notes

- Uses the `custom_lint` analyzer plugin.
- The base configuration lives in `lib/app.yaml`.

## Contributing

- Update rule sets in `lib/app.yaml`.
- Keep changes compatible with the workspace tooling.

## License

MIT License

Maintainers: Maintainers
