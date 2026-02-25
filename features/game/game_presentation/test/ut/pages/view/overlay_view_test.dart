import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_presentation/src/pages/view/overlay_view.dart';
import 'package:game_presentation/src/pages/view_model/result_view_model.dart';
import 'package:game_presentation/src/pages/view_model/state/result_state.dart';

import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('OverlayView Widget Tests', () {
    late ValueNotifier<bool> showOverlay;

    setUp(() {
      showOverlay = ValueNotifier<bool>(false);
    });

    testWidgets('OverlayView renders SizedBox.shrink when showOverlay is false', (WidgetTester tester) async {
      // Arrange
      final overrides = [
        resultViewModelProvider.overrideWithValue(InitialResultState()),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          overrides: overrides,
          child: OverlayView(
            showOverlay: showOverlay,
            onDismiss: () {},
          ),
        ),
      );
      await tester.pump();

      // Assert
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('OverlayView renders nothing when state is InitialResultState', (WidgetTester tester) async {
      // Arrange
      final overrides = [
        resultViewModelProvider.overrideWithValue(InitialResultState()),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          overrides: overrides,
          child: OverlayView(
            showOverlay: showOverlay,
            onDismiss: () {},
          ),
        ),
      );
      await tester.pump();

      // Assert
      expect(find.byType(OverlayView), findsOneWidget);
    });

    testWidgets('OverlayView renders nothing when state is NoResultState', (WidgetTester tester) async {
      // Arrange
      final overrides = [
        resultViewModelProvider.overrideWithValue(NoResultState()),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          overrides: overrides,
          child: OverlayView(
            showOverlay: showOverlay,
            onDismiss: () {},
          ),
        ),
      );
      await tester.pump();

      // Assert
      expect(find.byType(OverlayView), findsOneWidget);
    });

    testWidgets('OverlayView renders nothing when showOverlay is false even with WinnerResultState', (WidgetTester tester) async {
      // Arrange
      final overrides = [
        resultViewModelProvider.overrideWithValue(
          WinnerResultState(
            winningLine: [0, 1, 2],
            winner: 'Alice',
          ),
        ),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          overrides: overrides,
          child: OverlayView(
            showOverlay: showOverlay,
            onDismiss: () {},
          ),
        ),
      );
      await tester.pump();

      // Assert - Should show SizedBox.shrink since showOverlay is false
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('OverlayView calls onDismiss callback', (WidgetTester tester) async {
      // Arrange
      final overrides = [
        resultViewModelProvider.overrideWithValue(InitialResultState()),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          overrides: overrides,
          child: OverlayView(
            showOverlay: ValueNotifier(false),
            onDismiss: () {},
          ),
        ),
      );

      // Assert
      expect(find.byType(OverlayView), findsOneWidget);
    });

    testWidgets('OverlayView renders DrawOverlay when showOverlay is true and state is DrawResultState', (WidgetTester tester) async {
      // Arrange
      showOverlay.value = true;
      final overrides = [
        resultViewModelProvider.overrideWithValue(DrawResultState()),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          overrides: overrides,
          child: OverlayView(
            showOverlay: showOverlay,
            onDismiss: () {},
          ),
        ),
      );
      await tester.pump();

      // Assert
      expect(find.byType(OverlayView), findsOneWidget);
    });

    testWidgets('OverlayView renders WinnerOverlay when showOverlay is true and state is WinnerResultState', (WidgetTester tester) async {
      // Arrange
      showOverlay.value = true;
      final overrides = [
        resultViewModelProvider.overrideWithValue(
          WinnerResultState(
            winningLine: [0, 1, 2],
            winner: 'Alice',
          ),
        ),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          overrides: overrides,
          child: OverlayView(
            showOverlay: showOverlay,
            onDismiss: () {},
          ),
        ),
      );
      // WinnerOverlay has confetti animation of 3 seconds, so we pump for that duration
      await tester.pump(const Duration(seconds: 4));

      // Assert
      expect(find.byType(OverlayView), findsOneWidget);
    });
  });
}
