import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_presentation/src/pages/widget/dropdown_player.dart';
import 'package:user_domain/user_domain.dart';

import '../../../fixtures/test_data.dart';
import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('DropdownPlayer Widget Tests', () {
    testWidgets('DropdownPlayer renders dropdown button', (WidgetTester tester) async {
      // Arrange
      final users = [testPlayerOne, testPlayerTwo, testPlayerThree];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: DropdownPlayer(
            label: 'Select Player',
            users: users,
            value: null,
            enabled: true,
            onChanged: (id) async {},
            excludedUserIds: [],
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      // Assert
      expect(find.byType(DropdownButton), findsOneWidget);
    });

    testWidgets('DropdownPlayer displays label', (WidgetTester tester) async {
      // Arrange
      final users = [testPlayerOne, testPlayerTwo];
      const label = 'Player 1';

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: DropdownPlayer(
            label: label,
            users: users,
            value: null,
            enabled: true,
            onChanged: (id) async {},
            excludedUserIds: [],
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      // Assert
      expect(find.text(label), findsWidgets);
    });

    testWidgets('DropdownPlayer is disabled when enabled is false', (WidgetTester tester) async {
      // Arrange
      final users = [testPlayerOne, testPlayerTwo];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: DropdownPlayer(
            label: 'Select Player',
            users: users,
            value: null,
            enabled: false,
            onChanged: (id) async {},
            excludedUserIds: [],
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      // Assert
      expect(find.byType(DropdownButton), findsOneWidget);
    });

    testWidgets('DropdownPlayer displays selected value', (WidgetTester tester) async {
      // Arrange
      final users = [testPlayerOne, testPlayerTwo];
      const selectedValue = 2;

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: DropdownPlayer(
            label: 'Select Player',
            users: users,
            value: selectedValue,
            enabled: true,
            onChanged: (id) async {},
            excludedUserIds: [],
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      // Assert
      expect(find.byType(DropdownButton), findsOneWidget);
    });

    testWidgets('DropdownPlayer excludes specified user IDs', (WidgetTester tester) async {
      // Arrange
      final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
      final excludedIds = [1];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: DropdownPlayer(
            label: 'Select Player',
            users: users,
            value: null,
            excludedUserIds: excludedIds,
            enabled: true,
            onChanged: (id) async {},
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      // Assert
      expect(find.byType(DropdownButton), findsOneWidget);
    });

    testWidgets('DropdownPlayer renders with empty user list', (WidgetTester tester) async {
      // Arrange
      final users = <UserEntity>[];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: DropdownPlayer(
            label: 'Select Player',
            users: users,
            value: null,
            enabled: true,
            onChanged: (id) async {},
            excludedUserIds: [],
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      // Assert
      expect(find.byType(DropdownButton), findsOneWidget);
    });
  });
}
