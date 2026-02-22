# ErrorPage Tests

Ce paquet contient les tests unitaires et les golden tests pour la page d'erreur (ErrorPage) de l'application Triple T.

## Tests Unitaires (`error_page_test.dart`)

Les tests unitaires vérifient le comportement et l'apparence de la page d'erreur:

- **Rendu basique**: Vérifie que la page s'affiche correctement avec tous les éléments (icône, texte, bouton)
- **Messages d'erreur**: Teste l'affichage optionnel des messages d'erreur
- **Icône et styling**: Vérifie la taille et la couleur de l'icône d'erreur
- **Internationalisation**: Teste les traductions en anglais et en français
- **Interactivité**: Vérifie que le bouton peut être cliqué

### Exécuter les tests unitaires:

```bash
flutter test test/src/pages/error_page_test.dart
```

## Golden Tests (`error_page_golden_test.dart`)

Les golden tests comparent les rendus visuels de la page d'erreur avec des images de référence (golden files):

- **Sans message d'erreur**: Rendu basique
- **Avec message d'erreur**: Affichage du message d'erreur
- **Long message d'erreur**: Test du wrapping du texte long
- **Locale française**: Affichage en français
- **Icône affichée**: Test de l'icône d'erreur
- **String vide**: Test avec une chaîne d'erreur vide

### Exécuter les golden tests:

```bash
# Exécuter les tests
flutter test test/src/pages/error_page_golden_test.dart

# Mettre à jour les images de référence golden
flutter test --update-goldens test/src/pages/error_page_golden_test.dart
```

## Structure des tests

### Dépendances de test:

- `flutter_test`: Framework de test Flutter
- `mockito`: Mocking pour dépendances
- `hooks_riverpod`: Gestion d'état avec Riverpod

### Mocks:

- `MockErrorNavigator`: Mock de l'ErrorNavigator pour isoler les tests de navigation

## Taille de l'écran pour les Golden Tests

Les golden tests utilisent une taille d'écran mobile standard (1080x1920) pour assurer la cohérence des rendus.

## Fichiers générés

Les images golden sont stockées dans le répertoire `test/src/pages/goldens/`:

- `error_page_without_error.png`
- `error_page_with_error.png`
- `error_page_with_long_error.png`
- `error_page_french_locale.png`
- `error_page_icon_displayed.png`
- `error_page_with_empty_error.png`

## Notes

- Les tests utilisent `ProviderScope` avec des overrides pour fournir un mock d'ErrorNavigator
- Les localisations sont fournies par le package `tt_i18n`
- Les tests s'exécutent sans couvrir la couche de base de données grâce aux mocks

