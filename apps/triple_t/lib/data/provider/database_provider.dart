import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tt_database/tt_database.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
Database database(Ref ref) {
  return TripleTDatabase.instance.db;
}
