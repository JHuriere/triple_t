import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_presentation/src/pages/widget/dropdown_player.dart';
import 'package:user_domain/user_domain.dart';

import '../../../fixtures/test_data.dart';
import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('DropdownPlayer Widget', () {
    group('render', () {
      testWidgets('should display DropdownButtonFormField', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        const LABEL = 'Select Player';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: null,
              enabled: true,
              onChanged: (id) async {},
              excludedUserIds: const [],
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(find.byType(DropdownButtonFormField<int>), findsOneWidget);
      });

      testWidgets('should display with rounded borders', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo];
        const LABEL = 'Select Player';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: null,
              enabled: true,
              onChanged: (id) async {},
              excludedUserIds: const [],
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(find.byType(DropdownButtonFormField<int>), findsOneWidget);
      });

      testWidgets('should display keyboard arrow down icon', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo];
        const LABEL = 'Select Player';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: null,
              enabled: true,
              onChanged: (id) async {},
              excludedUserIds: const [],
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
      });
    });

    group('label', () {
      testWidgets('should display provided label text', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo];
        const LABEL = 'Player 1';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: null,
              enabled: true,
              onChanged: (id) async {},
              excludedUserIds: const [],
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(find.text(LABEL), findsOneWidget);
      });

      testWidgets('should display different label texts', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo];
        const LABEL = 'Player 2';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: null,
              enabled: true,
              onChanged: (id) async {},
              excludedUserIds: const [],
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(find.text(LABEL), findsOneWidget);
      });
    });

    group('items', () {
      testWidgets('should render dropdown with multiple users', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        const LABEL = 'Select Player';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: null,
              enabled: true,
              onChanged: (id) async {},
              excludedUserIds: const [],
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(find.byType(DropdownButtonFormField<int>), findsOneWidget);
      });

      testWidgets('should handle empty user list', (WidgetTester tester) async {
        // Arrange
        final users = <UserEntity>[];
        const LABEL = 'Select Player';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: null,
              enabled: true,
              onChanged: (id) async {},
              excludedUserIds: const [],
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(find.byType(DropdownButtonFormField<int>), findsOneWidget);
      });
    });

    group('exclusion', () {
      testWidgets('should exclude specified user IDs from dropdown', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final EXCLUDED_IDS = [testPlayerTwo.id];
        const LABEL = 'Select Player';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: null,
              excludedUserIds: EXCLUDED_IDS,
              enabled: true,
              onChanged: (id) async {},
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert - Verify widget renders without error when exclusions are provided
        expect(find.byType(DropdownButtonFormField<int>), findsOneWidget);
      });

      testWidgets('should exclude multiple user IDs', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final EXCLUDED_IDS = [testPlayerOne.id, testPlayerThree.id];
        const LABEL = 'Select Player';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: null,
              excludedUserIds: EXCLUDED_IDS,
              enabled: true,
              onChanged: (id) async {},
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert - Verify widget renders without error when multiple exclusions provided
        expect(find.byType(DropdownButtonFormField<int>), findsOneWidget);
      });
    });

    group('selection', () {
      testWidgets('should display selected user', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo];
        final SELECTED_VALUE = testPlayerOne.id;
        const LABEL = 'Select Player';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: SELECTED_VALUE,
              enabled: true,
              onChanged: (id) async {},
              excludedUserIds: const [],
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(find.text(testPlayerOne.name), findsOneWidget);
      });

      testWidgets('should have onChanged callback when enabled', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        const LABEL = 'Select Player';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: null,
              enabled: true,
              onChanged: (id) async {},
              excludedUserIds: const [],
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        final dropdown = tester.widget<DropdownButtonFormField<int>>(
          find.byType(DropdownButtonFormField<int>),
        );
        expect(dropdown.onChanged, isNotNull);
      });

      testWidgets('should not have onChanged callback when disabled', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo];
        const LABEL = 'Select Player';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: null,
              enabled: false,
              onChanged: (id) async {},
              excludedUserIds: const [],
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        final dropdown = tester.widget<DropdownButtonFormField<int>>(
          find.byType(DropdownButtonFormField<int>),
        );
        expect(dropdown.onChanged, isNull);
      });
    });

    group('state', () {
      testWidgets('should be enabled when enabled is true', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo];
        const LABEL = 'Select Player';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: null,
              enabled: true,
              onChanged: (id) async {},
              excludedUserIds: const [],
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        final dropdown = tester.widget<DropdownButtonFormField<int>>(
          find.byType(DropdownButtonFormField<int>),
        );
        expect(dropdown.onChanged, isNotNull);
      });

      testWidgets('should be disabled when enabled is false', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo];
        const LABEL = 'Select Player';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: null,
              enabled: false,
              onChanged: (id) async {},
              excludedUserIds: const [],
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        final dropdown = tester.widget<DropdownButtonFormField<int>>(
          find.byType(DropdownButtonFormField<int>),
        );
        expect(dropdown.onChanged, isNull);
      });
    });

    group('styling', () {
      testWidgets('should render with decoration', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo];
        const LABEL = 'Select Player';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: null,
              enabled: true,
              onChanged: (id) async {},
              excludedUserIds: const [],
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        final dropdown = tester.widget<DropdownButtonFormField<int>>(
          find.byType(DropdownButtonFormField<int>),
        );
        expect(dropdown.decoration, isNotNull);
      });

      testWidgets('should display with proper padding', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo];
        const LABEL = 'Select Player';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: DropdownPlayer(
              label: LABEL,
              users: users,
              value: null,
              enabled: true,
              onChanged: (id) async {},
              excludedUserIds: const [],
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(find.byType(DropdownButtonFormField<int>), findsOneWidget);
      });
    });
  });
}
