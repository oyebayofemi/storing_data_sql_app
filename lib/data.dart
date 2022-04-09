import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final tableName = 'datas';
final columnID = 'ID';
final columnName = 'Name';

class Data {
  var textss;
  int? id;

  Data({this.textss, this.id});

  Map<String, dynamic> toMap() {
    return {
      columnName: textss,
    };
  }
}

class Helper {
  late Database db;

  Helper() {
    iniDatabase();
  }

  Future<void> iniDatabase() async {
    db = await openDatabase(
      join(await getDatabasesPath(), "my_db.db"),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $tableName($columnID INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT)');
      },
      version: 1,
    );
  }

  Future<void> insertText(Data instance) async {
    try {
      db.insert(tableName, instance.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (error) {
      print(error);
    }
  }

  Future<List<Data>> getData() async {
    final List<Map<String, dynamic>> allData = await db.query(tableName);

    return List.generate(allData.length, (index) {
      return Data(
          textss: allData[index][columnName], id: allData[index][columnID]);
    });
  }
}
