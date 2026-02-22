import 'dart:async';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_test/golden_test.dart';
import 'package:tt_i18n/l10n/generated/app_localizations.g.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  goldenTestSupportMultipleDevices = true;
  goldenTestSupportedDevices = [
    const Device.iphone15Pro(),
    const Device.ipadPro12(),
  ];
  goldenTestSupportedLocales = AppLocalizations.supportedLocales;
  goldenTestLocalizationsDelegates = [
    AppLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  return testMain();
}
