# Triple T

Flutter application with **Riverpod** for state management and **GoRouter** for navigation, following **Clean Architecture** principles.

## 🚀 Quick Start

```bash
# Install dependencies
flutter pub get

# Run the application
flutter run
```

## 🔨 Code Generation

This project uses **build_runner** for code generation (models, providers, serialization, etc.).

### Generate Code

```bash
# Generate code files (recommended)
dart run build_runner build --delete-conflicting-outputs
```

### Watch Mode (Development)

```bash
# Watch for changes and regenerate automatically
dart run build_runner watch --delete-conflicting-outputs
```

### Clean Generated Files

```bash
# Remove all generated files
dart run build_runner clean
```

### Flags Explanation

- `--delete-conflicting-outputs` - Automatically resolves conflicts by deleting old generated files
- `watch` - Continuously monitors file changes and regenerates code
- `build` - One-time code generation

> 💡 **Tip**: Run this command after pulling changes or modifying files that require code generation (models with `@freezed`, `json_serializable`, etc.)

## 📦 Technologies

- **Flutter** - UI Framework
- **Riverpod** (v3.0.0) - Reactive state management with `hooks_riverpod`
- **GoRouter** (v17.1.0) - Declarative navigation
- **Flutter Hooks** (v0.21.3+1) - Hooks for Flutter
- **Freezed** (v3.2.3) - Code generation for models
- **JSON Serializable** (v6.0.0) - JSON serialization
- **Sembast** (v3.8.6) - NoSQL database for local storage
- **Confetti** (v0.7.0) - Confetti animation effects

## 🏗️ Clean Architecture

This project follows **Clean Architecture** principles to ensure separation of concerns, testability, and maintainability.

### Architecture Layers

```
┌─────────────────────────────────────────┐
│          PRESENTATION LAYER             │
│  (UI, Widgets, Pages, Providers)        │
│  - Depends on: Domain                   │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│            DOMAIN LAYER                 │
│  (Business Logic, Use Cases, Models)    │
│  - Independent (No external deps)       │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│             DATA LAYER                  │
│  (Repositories, Data Sources, Entities) │
│  - Depends on: Domain                   │
└─────────────────────────────────────────┘
```

### Layer Responsibilities

#### 📱 Presentation Layer (`lib/presentation/`)

- **Purpose**: UI components and user interactions
- **Contains**:
  - `pages/` - Screen widgets
  - `router/` - Navigation configuration
  - `providers/` - Riverpod state management
- **Dependencies**: Domain layer only
- **Rules**:
  - Never imports from Data layer directly
  - Uses providers to access use cases
  - Handles UI state and user input

#### 💼 Domain Layer (`lib/domain/`)

- **Purpose**: Business logic and rules
- **Contains**:
  - `model/` - Business models (pure Dart classes)
  - `use_case/` - Application business rules
  - `mapper/` - Data transformation logic
- **Dependencies**: None (pure Dart)
- **Rules**:
  - Framework independent
  - No Flutter/external dependencies
  - Contains abstract repository interfaces
  - Defines contracts for data layer

#### 💾 Data Layer (`lib/data/`)

- **Purpose**: Data access and external services
- **Contains**:
  - `repository/` - Repository implementations
  - `entity/` - Data models (DTOs)
  - `core/` - Data utilities and constants
- **Dependencies**: Domain layer (implements interfaces)
- **Rules**:
  - Implements domain repository interfaces
  - Handles API calls, database, cache
  - Converts entities to domain models

### Benefits

✅ **Testability** - Easy to unit test each layer independently  
✅ **Maintainability** - Clear separation of concerns  
✅ **Scalability** - Easy to add new features without breaking existing code  
✅ **Flexibility** - Easy to change data sources or UI framework  
✅ **Reusability** - Domain logic can be shared across platforms

## 📁 Project Structure

```
lib/
├── main.dart                              # Entry point with initialization
├── presentation/
│   ├── pages/                             # Application screens
│   └── router/
│       └── router_provider.dart           # GoRouter configuration
├── domain/
│   ├── domain.dart                        # Domain initialization and exports
│   ├── model/                             # Business models
│   ├── use_case/                          # Use cases
│   └── helper/                            # Domain helpers
└── data/
    ├── data.dart                          # Data initialization and exports
    ├── entity/                            # Data entities (DTOs)
    ├── repository/                        # Repository implementations
    └── core/                              # Data utilities and constants
```

## 📚 Documentation

- **[lib/presentation/router/README.md](lib/presentation/router/README.md)** - Router usage documentation (if available)

## 🎯 Features

- ✅ Declarative navigation with GoRouter
- ✅ State management with Riverpod
- ✅ Clean Architecture implementation
- ✅ Clean and maintainable architecture
- ✅ Provider examples (counter, authentication)
- ✅ Pre-configured pages
- ✅ Error handling (404)
- ✅ Deep linking ready

## 🔧 Configuration

The project is pre-configured with:

1. **ProviderScope** at the application root for Riverpod
2. **MaterialApp.router** configured with GoRouter
3. **Routes** defined in the router configuration
4. **Native splash screen** with custom branding

## 📖 Usage Examples

### Navigation

```dart
// Push a route
context.push
('/profile
'
);

// Go (replaces the route)
context.go('/settings');

// Go back
context.pop
(
);
```

### State Management

```dart
class MyWidget extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read state
    final state = ref.watch(myProvider);

    // Modify state
    ref.read(myProvider.notifier).updateState(newValue);

    return Text('$state');
  }
}
```

### Clean Architecture Flow Example

```dart
// 1. PRESENTATION: User taps button
ElevatedButton
(
onPressed: () {
// Call use case via provider
ref.read(myUseCaseProvider).execute(parameters);
},
)

// 2. DOMAIN: Use case executes business logic
class MyUseCase {
final MyRepository repository;

Future<Result> execute(Parameters params) {
// Business logic here
return repository.doSomething(params);
}
}

// 3. DATA: Repository fetches data
class MyRepositoryImpl implements MyRepository {
@override
Future<Result> doSomething(Parameters params) {
// API call, database query, etc.
return dataSource.fetch(params);
}
}
```

## 🔗 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Clean Architecture (Uncle Bob)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

## 📝 License

This project is a Flutter starter template.
