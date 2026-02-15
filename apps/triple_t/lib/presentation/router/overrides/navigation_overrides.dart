import 'package:home_presentation/home_presentation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triple_t/presentation/router/app_navigator.dart';

/// Home package overrides
sealed class NavigatorOverrides {
  static List<Override> get() => [
    getHomeNavigatorProvider.overrideWith((ref) => ref.watch(appNavigatorProvider)),
  ];
}
