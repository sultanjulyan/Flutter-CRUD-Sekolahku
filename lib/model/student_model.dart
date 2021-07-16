import 'dart:async';
import 'package:sqflite/sqflite.dart';

class StudentModel {

  FutureOr<void> onCreate(Database db, int version) async {
    String sqlRaw = '''
        
    CREATE TABLE IF NOT EXISTS siswa(
    id_siswa INTEGER PRIMARY KEY NOT NULL,
    first_name TEXT(20),
    last_name TEXT(20),
    gender TEXT(6),
    grade TEXT(3),
    address TEXT(45),
    mobile_phone TEXT(13),
    hobbies TEXT
    );
    
    ''';

    String sqlRawTeacher = '''
        
    CREATE TABLE IF NOT EXISTS guru(
    id_guru INTEGER PRIMARY KEY NOT NULL,
    first_name TEXT(20),
    last_name TEXT(20),
    mobile_phone TEXT(13),
    gender TEXT(6),
    mapel TEXT(20),
    address TEXT(45),
    birth_date TEXT(10)
    );
    
    ''';

    String sqlRawUser = '''
        
    CREATE TABLE IF NOT EXISTS user(
    id_user INTEGER PRIMARY KEY NOT NULL,
    email TEXT(30),
    password TEXT(8)
    );
    
    ''';

    await db.execute(sqlRaw);
    await db.execute(sqlRawTeacher);
    await db.execute(sqlRawUser);
  }

  FutureOr<void> onConfigure(Database db) {
  }

  FutureOr<void> onDowngrade(Database db, int oldVersion, int newVersion) {
  }

  FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion) {
  }
}