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
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))(); // Soft delete flag

  // Meta fields
  DateTimeColumn get created => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updated => dateTime().nullable()();
}

class SettingsTable extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [Notes, SettingsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'notes_db');
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(settingsTable);
        }
        if (from < 3) {
          await m.addColumn(notes, notes.isDeleted);
        }
      },
    );
  }

  // API Key helpers
  Future<void> saveApiKey(String apiKey) async {
    await into(settingsTable).insertOnConflictUpdate(
      SettingsTableCompanion.insert(key: 'api_key', value: apiKey),
    );
  }

  Future<String?> getApiKey() async {
    final query = select(settingsTable)..where((t) => t.key.equals('api_key'));
    final result = await query.getSingleOrNull();
    return result?.value;
  }

  /// Deletes all notes marked as [isDeleted] from the local database.
  /// Used for cleanup after successful sync.
  Future<void> deleteSoftDeletedNotes() async {
    await (delete(notes)..where((t) => t.isDeleted.equals(true))).go();
  }
}
