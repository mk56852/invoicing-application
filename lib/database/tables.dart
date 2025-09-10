import 'package:drift/drift.dart';

class UserEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get ref => text()();
  TextColumn get title => text()();
  RealColumn get price => real()();
}

class SettingEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get lastName => text()();
  TextColumn get email => text()();
  TextColumn get phone1 => text()();
  TextColumn get phone2 => text()();
  TextColumn get dbDirectory => text()();
  TextColumn get factureDirectory => text()();
  RealColumn get price => real()();
  IntColumn get tva => integer()();
  IntColumn get factureNumber => integer()();
}
