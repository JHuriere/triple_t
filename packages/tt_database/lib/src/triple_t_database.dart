import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class TripleTDatabase {
  TripleTDatabase._();

  static int kCurrentVersion = 1;
  static String kDbName = 'triple_t.db';
  late Database _db;

  static final TripleTDatabase _singleton = TripleTDatabase._();

  static TripleTDatabase get instance => _singleton;

  // Allows tests to inject an in-memory or mock database instance.
  // Use only in test environments.
  static void setTestDatabase(Database db) {
    _singleton._db = db;
  }

  Future<void> openDatabase() async {
    DatabaseFactory dbFactory;
    String path;

    if (kIsWeb) {
      dbFactory = databaseFactoryWeb;
      path = kDbName;
    } else {
      dbFactory = databaseFactoryIo;
      final appDocumentDir = await getApplicationDocumentsDirectory();
      await appDocumentDir.create(recursive: true);
      path = join(appDocumentDir.path, kDbName);
    }

    _db = await dbFactory.openDatabase(path, version: kCurrentVersion, onVersionChanged: (db, oldVersion, newVersion) {}, mode: DatabaseMode.create);
  }

  Database get db => _db;
}
