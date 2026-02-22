import 'package:error_presentation/src/router/navigator/error_navigator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_error_navigator.g.dart';

@riverpod
ErrorNavigator getErrorNavigator(Ref ref) {
  throw UnimplementedError('Missing getErrorNavigator override in main.dart');
}
