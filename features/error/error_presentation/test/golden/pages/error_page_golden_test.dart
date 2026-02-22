import 'package:error_presentation/src/pages/error_page.dart';
import 'package:error_presentation/src/router/router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_test/golden_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

class MockErrorNavigator extends Mock implements ErrorNavigator {}

void main() {
  group('ErrorPage Golden Tests', () {
    late MockErrorNavigator mockErrorNavigator;

    setUp(() {
      mockErrorNavigator = MockErrorNavigator();
    });

    goldenTest(
      name: 'without error message',
      builder: (_) => ProviderScope(
        overrides: [
          getErrorNavigatorProvider.overrideWithValue(mockErrorNavigator),
        ],
        child: const ErrorPage(),
      ),
    );

    goldenTest(
      name: 'with empty string error',
      builder: (_) => ProviderScope(
        overrides: [
          getErrorNavigatorProvider.overrideWithValue(mockErrorNavigator),
        ],
        child: const ErrorPage(error: ''),
      ),
    );

    goldenTest(
      name: 'with error message',
      builder: (_) => ProviderScope(
        overrides: [
          getErrorNavigatorProvider.overrideWithValue(mockErrorNavigator),
        ],
        child: const ErrorPage(error: 'Failed to load the requested resource'),
      ),
    );

    goldenTest(
      name: 'with long error message',
      builder: (_) => ProviderScope(
        overrides: [
          getErrorNavigatorProvider.overrideWithValue(mockErrorNavigator),
        ],
        child: const ErrorPage(
          error:
              'This is a very long error message that might wrap to multiple lines to test the layout with a detailed error description that explains what went wrong in the application',
        ),
      ),
    );
  });
}
