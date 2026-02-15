import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:triple_t/data/data.dart';
import 'package:triple_t/domain/domain.dart';
import 'package:triple_t/presentation/pages/app.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Data.init();
  await Domain.init();

  FlutterNativeSplash.remove();

  runApp(
    ProviderScope(
      retry: (retryCount, error) => null,
      child: const TripleTApp(),
    ),
  );
}
