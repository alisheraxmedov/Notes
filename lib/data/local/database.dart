import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get date => text()(); // User selected date
  TextColumn get time => text()(); // User selected time or UI creation time

  // Optional fields
  TextColumn get nDate => text().nullable()(); // Notification Date
  TextColumn get nTime => text().nullable()(); // Notification Time
  TextColumn get today => text().nullable()(); // Modification/Sort key

  // Meta fields
  DateTimeColumn get created => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updated => dateTime().nullable()();
}

@DriftDatabase(tables: [Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'notes_db');
  }
}
