import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:management_app/configuration/utils.dart';
import 'package:management_app/database/tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [UserEntity])
class AppDatabase extends _$AppDatabase {
  static AppDatabase db = AppDatabase._internal();
  AppDatabase._internal([QueryExecutor? executor])
      : super(executor ?? _openConnection());

  factory AppDatabase() {
    return db;
  }

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: DriftNativeOptions(
        databaseDirectory: () async => Directory(databasePath),
      ),
    );
  }
}
