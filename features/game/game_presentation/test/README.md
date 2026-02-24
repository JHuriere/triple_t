# Tests pour game_presentation

Ce document décrit la structure et les patterns de test utilisés dans le package `game_presentation`.

## Structure des tests

```
test/
├── ut/                          # Unit Tests
│   └── view_model/
│       ├── current_game_view_model_test.dart
│       └── result_view_model_test.dart
├── wt/                          # Widget Tests
│   ├── pages/
│   │   └── game_page_test.dart
│   ├── view/
│   │   ├── game_view_test.dart
│   │   └── overlay_view_test.dart
│   └── widget/
│       ├── game_grid_test.dart
│       ├── game_statistics_test.dart
│       ├── select_players_test.dart
│       ├── dropdown_player_test.dart
│       └── overlay/
│           ├── winner_overlay_test.dart
│           └── draw_overlay_test.dart
├── fixtures/
│   ├── test_data.dart           # Données de test réutilisables
│   └── mock_providers.dart      # Mocks des providers Riverpod
├── helpers/
│   └── widget_test_helpers.dart # Utilitaires pour les tests widget
└── README.md                     # Ce fichier
```

## Tests unitaires (UT)

### CurrentGameViewModel Tests

Tests les méthodes du ViewModel de gestion du jeu actuel:

- **build()**: Vérifie l'initialisation avec les données correctes
- **playNextMove()**: Teste la mise à jour des éléments du plateau avec l'émoticône du joueur
- **playNextAIMove()**: Teste les coups de l'IA et les conditions de retour

**Cas couverts:**

- Coups du joueur normal
- Coups de l'IA (playerTwo avec ID 1)
- Vérification des tours (oTurn)

### ResultViewModel Tests

Tests la détection des résultats du jeu:

- **build()**: Vérifie l'état initial
- **checkResult()**: Teste la détection de gagnant, d'égalité et de continuité du jeu

**Cas couverts:**

- Détection d'une ligne gagnante
- Détection d'une égalité (plateau complet)
- État de jeu en cours (pas de résultat)

## Tests widget (WT)

### Tests des Pages

#### GamePage Tests

Tests la page principale du jeu:

- Rendu correct de l'AppBar
- Présence du bouton de réinitialisation
- Rendu du GameView et OverlayView
- Appel des callbacks appropriés

### Tests des Vues

#### GameView Tests

Tests la vue affichant le jeu:

- Rendu de tous les sous-widgets
- Affichage du tour du joueur actuel
- Gestion des appels onTap
- Rendu avec différents états (plateau vide, plateau rempli)

#### OverlayView Tests

Tests la vue d'overlay:

- Affichage conditionnel basé sur showOverlay
- Rendu de WinnerOverlay quand état = WinnerResultState
- Rendu de DrawOverlay quand état = DrawResultState
- Rendu du SizedBox.shrink quand showOverlay = false

### Tests des Widgets

#### GameGrid Tests

Tests la grille de jeu:

- Rendu de 9 cellules
- Affichage correct des émoticônes
- Appel des callbacks onTap
- Animations de ligne gagnante

#### GameStatistics Tests

Tests l'affichage des statistiques:

- Rendu des trois cartes de stats (joueur1, égalités, joueur2)
- Affichage des noms et émoticônes
- Affichage des compteurs de victoires/égalités
- Mise à jour correcte des valeurs

#### SelectPlayers Tests

Tests la sélection des joueurs:

- Rendu de deux dropdowns
- État activé/désactivé selon l'état du jeu
- Appel des callbacks de changement
- Exclusion du joueur sélectionné de l'autre dropdown

#### DropdownPlayer Tests

Tests le dropdown de sélection d'un joueur:

- Rendu du bouton dropdown
- Affichage du label
- Affichage des options
- Appel du callback onChanged
- État activé/désactivé
- Exclusion des utilisateurs spécifiés

#### WinnerOverlay Tests

Tests l'overlay de victoire:

- Affichage du nom du gagnant
- Animation de confettis
- Bouton de fermeture
- Appel du callback onDismiss
- Rendu fullscreen

#### DrawOverlay Tests

Tests l'overlay d'égalité:

- Affichage du message d'égalité
- Bouton de fermeture
- Appel du callback onDismiss
- Centrage du contenu
- Fond semi-transparent

## Fixtures de test

### test_data.dart

Contient les données de test réutilisables:

- `testCurrentGameEntity`: Jeu standard pour les tests
- `testPlayerOne`, `testPlayerTwo`, `testPlayerThree`: Joueurs
- `testPlayerOneModel`, `testPlayerTwoModel`, `testPlayerThreeModel`: Modèles utilisateur
- `testGameWithWinner`: Jeu avec une ligne gagnante
- `testGameDraw`: Jeu en égalité
- `testGameInProgress`: Jeu en cours
- `testGameInitial`: Jeu vierge

### mock_providers.dart

Contient les mocks Mockito:

- `MockGetCurrentGameUseCase`
- `MockUpdateCurrentGameElementsUseCase`
- `MockUpdateCurrentGameStateUseCase`
- `MockUpdateCurrentGamePlayerUseCase`
- `MockResetCurrentGameUseCase`
- `MockGetUserByIdUseCase`
- `MockGetAllUsersUseCase`
- `MockUpdateUserStatisticsUseCase`
- `MockUpdateUserUseCase`
- `MockGameHelper`

## Utilitaires de test

### widget_test_helpers.dart

Fournit des helpers pour simplifier les tests widget:

- `createTestableWidget()`: Crée un MaterialApp avec ProviderScope
- `WidgetTesterExtension`: Ajoute des méthodes pratiques à WidgetTester
  - `tapText()`: Tape sur un widget avec du texte
  - `expectTextExists()`: Vérifie la présence d'un texte
  - `expectTextNotExists()`: Vérifie l'absence d'un texte
  - `fillInputField()`: Remplit un champ de saisie

## Patterns utilisés

### Arrange-Act-Assert (AAA)

Tous les tests suivent le pattern AAA:

```dart
testWidgets
('description du test
'
, (WidgetTester tester) async {
// Arrange - Préparer les données et le contexte
final overrides = [...];

// Act - Exécuter l'action
await tester.pumpWidget(...);

// Assert - Vérifier les résultats
expect(find.byType(Widget), findsOneWidget);
});
```

### Mocking avec Riverpod

Les tests utilisent `ProviderContainer` avec `overrides` pour mocker les providers:

```dart
container = ProviderContainer
(
overrides: [
getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
],
);
```

### Async/Await pour les opérations asynchrones

```dart
await
tester.pumpAndSettle
(); // Attend la fin de toutes les animations
await
Future.delayed
(
const
Duration
(
milliseconds
:
600
)
);
```

## Exécution des tests

### Tous les tests

```bash
cd features/game/game_presentation
flutter test
```

### Tests unitaires uniquement

```bash
flutter test test/ut/
```

### Tests widget uniquement

```bash
flutter test test/wt/
```

### Un fichier de test spécifique

```bash
flutter test test/ut/view_model/current_game_view_model_test.dart
```

### Avec coverage

```bash
flutter test --coverage
```

## Bonnes pratiques

1. **Nommer les tests de façon descriptive**: Le nom du test doit décrire exactement ce qui est testé
2. **Un test = Une assertion principale**: Chaque test ne doit tester qu'une seule chose
3. **Utiliser les fixtures**: Réutiliser les données de test de `test_data.dart`
4. **Tester les cas limites**: Tester non seulement le cas heureux mais aussi les erreurs
5. **Tester les interactions utilisateur**: Vérifier que les callbacks sont appelés correctement
6. **Cleanup approprié**: Disposer les ressources (containers, ValueNotifiers, etc.) après les tests

## Couverture de code

Les tests couvrent:

- ✅ Tous les ViewModels
- ✅ La page principale (GamePage)
- ✅ Les vues principales (GameView, OverlayView)
- ✅ Les widgets majeurs (GameGrid, GameStatistics, SelectPlayers)
- ✅ Les widgets d'overlay (WinnerOverlay, DrawOverlay)
- ✅ Les interactions utilisateur
- ✅ Les transitions d'état

## Développement futur

À considérer pour l'amélioration des tests:

1. Augmenter la couverture des routes (GoRouter)
2. Ajouter des tests d'intégration complets
3. Tester les animations de ligne gagnante
4. Ajouter des tests de performance
5. Améliorer la couverture des cas d'erreur

