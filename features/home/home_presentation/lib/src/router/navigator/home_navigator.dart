import 'package:flutter/material.dart';

abstract class HomeNavigator {
  /// Navigate to the profile screen.
  void goGame(BuildContext context);

  /// Navigate to the user list screen.
  void goUserList(BuildContext context);

  /// Navigate to the global statistics screen.
  void goGlobalStatistics(BuildContext context);

  /// Navigate to the settings screen.
  void goSettings(BuildContext context);
}
