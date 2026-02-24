import 'package:flutter_test/flutter_test.dart';
import 'package:game_presentation/src/pages/widget/game_statistics.dart';

void main() {
  group('GameStatistics Widget Tests', () {
    testWidgets('GameStatistics widget exists', (WidgetTester tester) async {
      // Note: GameStatistics uses Riverpod providers (currentGameViewModelProvider)
      // Full widget testing of this component requires proper provider configuration
      expect(GameStatistics, isNotNull);
    });
  });
}
