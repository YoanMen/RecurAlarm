import 'package:path/path.dart';
import 'package:recurring_alarm/data/local/models/reminder_response.dart';
import 'package:recurring_alarm/data/local/models/reminder_send.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

late Future<Database> database;

final List<ReminderResponse> mockLocalDatabase = [];

abstract class LocalDatabase {
  void getDatabase();
  Future updateReminder();
  Future fetchAllReminders();
  Future addReminder();
  Future removeReminder();
  void deleteAll();
}

class SqlfLite implements LocalDatabase {
  final int _version = 1;
  final String _dbName = "reminders";

  @override
  Future addReminder() {
    // TODO: implement addReminder
    throw UnimplementedError();
  }

  @override
  void deleteAll() {
    // TODO: implement deleteAll
  }

  @override
  Future fetchAllReminders() {
    // TODO: implement fetchAllReminders
    throw UnimplementedError();
  }

  @override
  Future<Database> getDatabase() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE reminders(uuid TEXT PRIMARY KEY, description TEXT, begin_date TEXT, icon INTEGER, time_reminder TEXT, when_in_month INTEGER, next_reminder TEXT, reminder_type INTEGER, days TEXT, duration_between_reminding INTEGER, is_enabled INTEGER, create_at TEXT)"),
        version: _version);
  }

  @override
  Future removeReminder() {
    // TODO: implement removeReminder
    throw UnimplementedError();
  }

  @override
  Future updateReminder() {
    // TODO: implement updateReminder
    throw UnimplementedError();
  }
}
