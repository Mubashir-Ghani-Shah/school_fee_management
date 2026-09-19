import 'package:sqflite_common/sqlite_api.dart';

import 'database_factory.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databaseFactory = createDatabaseFactory();

    return databaseFactory.openDatabase(
      'school_fee_management.db',
      options: OpenDatabaseOptions(
        version: 2,

        // New database
        onCreate: (db, version) async {
          await _createStudentsTable(db);
          await _createPaymentsTables(db);
        },

        // Existing database: version 1 → version 2
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await _createPaymentsTables(db);
          }
        },
      ),
    );
  }

  Future<void> _createStudentsTable(Database db) async {
    await db.execute('''
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        student_class TEXT NOT NULL,
        monthly_fee INTEGER NOT NULL,
        category TEXT NOT NULL,
        advance_balance INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  Future<void> _createPaymentsTables(Database db) async {
    await db.execute('''
      CREATE TABLE payments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        student_id INTEGER NOT NULL,
        amount INTEGER NOT NULL,
        payment_date TEXT NOT NULL,
        FOREIGN KEY (student_id) REFERENCES students (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE payment_allocations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        payment_id INTEGER NOT NULL,
        month TEXT NOT NULL,
        amount INTEGER NOT NULL,
        FOREIGN KEY (payment_id) REFERENCES payments (id)
      )
    ''');
  }
}