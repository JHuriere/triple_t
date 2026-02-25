import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:triple_t/data/data.dart';
import 'package:triple_t/domain/domain.dart';
import 'package:triple_t/domain/overrides/repository_overrides.dart';
import 'package:triple_t/domain/overrides/use_case_overrides.dart';
import 'package:triple_t/presentation/app.dart';

import 'presentation/router/overrides/navigation_overrides.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Data.init();
  await Domain.init();

  FlutterNativeSplash.remove();

  runApp(
    ProviderScope(
      retry: (retryCount, error) => null,
      overrides: [
        ...NavigatorOverrides.get(),
        ...RepositoryOverrides.get(),
        ...UseCaseOverrides.get(),
      ],
      child: const TripleTApp(),
    ),
  );
}
