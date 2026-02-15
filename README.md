# Triple T Workspace

Multi-package Flutter workspace managed with **Melos**, containing the Triple T application.

## 📦 Project Structure

This project uses a **Melos workspace** architecture to manage multiple Flutter packages consistently.

```
triple_t/
├── apps/
│   └── triple_t/          # Main Flutter application
└── pubspec.yaml           # Workspace configuration
```

## 🚀 Installation

### Prerequisites

- Flutter SDK 3.10.8
- Dart SDK 3.10.8
- Melos CLI installed globally

### Install Melos

```bash
dart pub global activate melos
```

### Initialize the Workspace

```bash
# Bootstrap all workspace packages
melos bootstrap

# Or manually
flutter pub get
```

## 🔨 Available Melos Scripts

### Code Generation

```bash
# Generate code for all packages
melos run generate:all

# Generate only models/providers
melos run generate

# Generate only localization files
melos run generate:l10n
```

### Cleaning

```bash
# Deep clean all packages
melos run clean:deep
```

This script performs:

- `flutter clean` on all packages
- Deletion of `.lock` files
- Deletion of `pubspec_overrides.yaml`
- Deletion of generated files (`*.freezed.dart`, `*.g.dart`, `*.mocks.dart`)

## 🏗️ Architecture

The project follows **Clean Architecture** principles with:

- **Presentation Layer** - UI and state management with Riverpod
- **Domain Layer** - Business logic and use cases
- **Data Layer** - Data sources and repositories

### Main Technologies

- **Flutter** - UI Framework
- **Riverpod** - State management and dependency injection
- **GoRouter** - Navigation
- **Melos** - Multi-package workspace management
- **Sembast** - Local NoSQL database
- **Freezed** - Immutable model generation
- **Build Runner** - Code generation

## 🛠️ Development

### Launch the Application

```bash
# From the workspace root
cd apps/triple_t
flutter run

# Or with Melos (if configured)
melos exec --scope="triple_t" -- flutter run
```

### Code Generation in Development

```bash
# Watch mode for automatic generation
cd apps/triple_t
dart run build_runner watch --delete-conflicting-outputs
```

### List Packages

```bash
# Display all workspace packages
melos list

# Check for cyclic dependencies
melos list --cycles
```

## 📱 Triple T Application

The main application is located in `apps/triple_t/`.

For more information about the application, see the [application README](apps/triple_t/README.md).

## 🔧 Melos Configuration

The workspace is configured with:

- Sequential execution of `pub get` (`runPubGetInParallel: false`)
- Root is not treated as a package (`useRootAsPackage: false`)
- Post-bootstrap hook to check for cyclic dependencies

## 📝 Conventions

### Adding a New Package

1. Create the package in the appropriate folder (`apps/` or `packages/`)
2. Add it to the `workspace` list in `pubspec.yaml`
3. Run `melos bootstrap`

### Dependencies Between Packages

Use workspace dependencies in `pubspec.yaml`:

```yaml
dependencies:
  other_package:
    path: ../other_package
```

## 🤝 Contributing

1. Create a branch for your feature
2. Generate code with `melos run generate:all`
3. Test the changes
4. Create a pull request

## 📄 License

This project is private and not published on pub.dev.

---

**Note**: This workspace is designed to facilitate the development and maintenance of a modular and scalable Flutter application.

