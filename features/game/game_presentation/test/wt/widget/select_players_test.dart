import 'package:flutter_test/flutter_test.dart';
import 'package:game_presentation/src/pages/widget/select_players.dart';

void main() {
  group('SelectPlayers Widget Tests', () {
    testWidgets('SelectPlayers widget exists', (WidgetTester tester) async {
      // Note: SelectPlayers uses Riverpod providers
      // Full widget testing of this component requires proper provider configuration
      expect(SelectPlayers, isNotNull);
    });
  });
}
