---
applyTo: "**/*/test/ut/**"
---

# Unit testing Guidelines

**Test Template:**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:tt_i18n/i18n.dart';

void main() {
  setUpAll(() async {
    // ...
  });

  group('Class to test', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    group('method to test', () {
      test('should return expected result when conditions are met', () {
        // Arrange
        const expectedResult = { /* use Mockito ... */
        };

        // Act
        const result = await service.methodName('param');

        // Assert
        expect(result.elements, isNotEmpty);
      });
    });
  });
}
```

**RULES:**
Organization folder rules:

- Unit tests must be placed in the `./test/ut` folder
- The folder `./test/ut` must follow as much as possible the same architecture than the folder `./src` (`./src/folder/my_class.dart` => `./test/ut/folder/my_class_test.dart`)
- The file test must follow as much as possible the same methods/functions order than the tested file

Organization inside each test file rules:

- Unit test are solitary (only sociable when calling private methods). Mock all dependencies using `overrideProvider`.
- Use `test`
- Test descriptions should start with "should"

Tests data rules:

- Data used for tests are saved under `data` folders. Favorise current test's data folder (`./test/ut/folder/data`). Reused existing data as much as possible
- Mock data names should be uppercase and snake case

General rules for each test:

- Follow "Arrange-Act-Assert" pattern
- Follow existing patterns and structures in the codebase. Rules from this file always prevail over existing ones
- Always test both success and error paths
- When testing an exception, use `try{} catch(error){} finally{}` pattern
