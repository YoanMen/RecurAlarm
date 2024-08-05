import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:recurring_alarm/core/failure.dart';
import 'package:recurring_alarm/data/local/models/reminder_response.dart';
import 'package:recurring_alarm/data/local/models/reminder_send.dart';
import 'package:sqflite/sqflite.dart';

final List<ReminderResponse> mockLocalDatabase = [];

final reminderlocalDdbProvider = Provider<LocalDatabase>((ref) {
  return SqlfLite();
});

abstract class LocalDatabase {
  Future<Database> getDatabase();
  Future updateReminder(ReminderSend reminder);
  Future<List<ReminderResponse>> fetchAllReminders();
  Future addReminder(ReminderSend reminderSend);
  Future removeReminder(ReminderSend reminderSend);
  Future deleteAll();
}

class SqlfLite implements LocalDatabase {
  final int _version = 1;
  final String _dbName = "reminders";

  @override
  Future<Database> getDatabase() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE reminders(uuid TEXT PRIMARY KEY, reminder_enable INTEGER, create_at TEXT, description TEXT, time TEXT, days TEXT, begin_date TEXT, reminders_date TEXT,lenght_between_reminder INTEGER, reminder_type INTEGER, when_in_month INTEGER)"),
        version: _version);
  }

  @override
  Future<List<ReminderResponse>> fetchAllReminders() async {
    List<Map<String, dynamic>> maps;

    try {
      final db = await getDatabase();

      maps = await db.query("reminders");

      if (db.isOpen) {
        await db.close();
      }
    } catch (error) {
      throw Failure(
        message: "Cant get database $error",
      );
    }

    return List.generate(
        maps.length, (index) => ReminderResponse.fromMap(maps[index]));
  }

  @override
  Future addReminder(ReminderSend reminderSend) async {
    try {
      final db = await getDatabase();

      await db.insert("reminders", reminderSend.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      if (db.isOpen) {
        await db.close();
      }
    } catch (error) {
      throw Failure(
        message: "Cant add reminder $error",
      );
    }
  }

  @override
  Future removeReminder(ReminderSend reminder) async {
    try {
      final db = await getDatabase();

      await db.delete(
        "reminders",
        where: "uuid = ?",
        whereArgs: [reminder.uuid],
      );
      if (db.isOpen) {
        await db.close();
      }
    } catch (error) {
      throw Failure(message: "cant remove reminder $error");
    }
  }

  @override
  Future updateReminder(ReminderSend reminder) async {
    try {
      final db = await getDatabase();

      await db.update("reminders", reminder.toMap(),
          where: "uuid = ?",
          whereArgs: [reminder.uuid],
          conflictAlgorithm: ConflictAlgorithm.replace);
      if (db.isOpen) {
        await db.close();
      }
    } catch (error) {
      throw Failure(message: "cant update reminder $error");
    }
  }

  @override
  Future deleteAll() async {
    try {
      final db = await getDatabase();

      if (db.isOpen) {
        await db.close();
      }
      await databaseFactory.deleteDatabase(db.path);
    } catch (error) {
      throw Failure(
        message: "Cant get delete reminder $error",
      );
    }
  }
}
