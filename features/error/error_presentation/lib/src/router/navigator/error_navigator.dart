import 'package:flutter/material.dart';

abstract class ErrorNavigator {
  /// Navigate to the home screen.
  /// Use goHome instead of pop to ensure that the user is taken to the correct home screen,
  /// even if they navigated to the error page from a different part of the app.
  void goHome(BuildContext context);
}
