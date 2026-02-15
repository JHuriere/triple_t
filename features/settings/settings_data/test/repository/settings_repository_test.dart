import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_data/src/entity/settings/settings_entity.dart';
import 'package:settings_data/src/repository/settings_repository.dart';
import 'package:tt_database/src/triple_t_database.dart';

void main() {
  late ProviderContainer container;

  setUpAll(() async {
    // Initialize bindings so path_provider works in tests
    TestWidgetsFlutterBinding.ensureInitialized();

    // Mock path_provider to return a temp directory for getApplicationDocumentsDirectory
    const channel = MethodChannel('plugins.flutter.io/path_provider');
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return Directory.systemTemp.path;
      }
      return null;
    });

    // Open the real Sembast database (will be created in a temp dir during tests).
    await TripleTDatabase.instance.openDatabase();
  });

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() async {
    container.dispose();
  });

  test('get returns default SettingsEntity when nothing saved', () {
    final repo = container.read(settingsRepositoryProvider);

    final settings = repo.get();

    expect(settings.id, equals('settings'));
    expect(settings.themeMode, equals('system'));
    expect(settings.locale, equals('fr'));
  });

  test('saveSettings persists and get returns stored entity', () async {
    final repo = container.read(settingsRepositoryProvider);

    final toSave = SettingsEntity(id: 'settings', themeMode: 'dark', locale: 'en');
    await repo.saveSettings(toSave);

    final loaded = repo.get();

    expect(loaded.id, equals('settings'));
    expect(loaded.themeMode, equals('dark'));
    expect(loaded.locale, equals('en'));
  });

  test('clearAll removes stored settings and get returns default', () async {
    final repo = container.read(settingsRepositoryProvider);

    final toSave = SettingsEntity(id: 'settings', themeMode: 'dark', locale: 'en');
    await repo.saveSettings(toSave);

    // ensure saved
    var loaded = repo.get();
    expect(loaded.themeMode, equals('dark'));

    await repo.clearAll();

    loaded = repo.get();
    expect(loaded.id, equals('settings'));
    expect(loaded.themeMode, equals('system'));
    expect(loaded.locale, equals('fr'));
  });
}
