import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqlLite {
  Future<Database> openConnection() async {
    final dataBasePath = await getDatabasesPath();
    final dataBaseFinalPath = join(dataBasePath, 'REGISTRO_HORAS');

    return await openDatabase(
      dataBaseFinalPath,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys =ON');
      },
      onCreate: (db, version) {
        final batch = db.batch();

        batch.execute('''
        create table registro(id integer primary key autoincrement,
        descricao varchar(200),
        datainicial varchar(200),
        hora  varchar(60),
        tipoEntrada varchar(2)
        )
        
        
         ''');
        batch.commit();
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion == 0) {
          final batch = db.batch();
          String sql = "DROP TABLE IF EXISTS registro";
          batch.execute(sql);
          batch.commit();
        }
        // String sql = "DROP TABLE IF EXISTS registro";
        // db.execute(sql);
      },
      onDowngrade: (db, oldVersion, newVersion) {
        // if (oldVersion == 1) {
        //   final batch = db.batch();
        //   String sql = "DROP TABLE IF EXISTS registro";
        //   batch.execute(sql);
        //   batch.commit();

        // String sql = "DROP TABLE IF EXISTS registro";
        // db.execute(sql);
      },
      singleInstance: false,
    );
  }
}
