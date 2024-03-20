
import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:top_flutter_repositories/constants/db_table_constants.dart';

final class DbSingleton {
  DbSingleton._private();
  static final DbSingleton _singleton = DbSingleton._private();
  static DbSingleton get instance => _singleton;

  static const databaseVersion = 1;
  static const _databaseName = 'com.sauvik.githubFlutter';
  late Database db;

  Future<Database> create() async {
    db = await openDatabase(join(await getDatabasesPath(), _databaseName), onCreate: (db, version) async {
      final batch = db.batch();
      _createDataListTableV1(batch);
      await batch.commit();
    },
    version: databaseVersion
    );
    log(db.toString());
    return db;
  }

  void _createDataListTableV1(Batch batch) {
  batch.execute('''
    CREATE TABLE ${TableConst.kDetailsTableName}
    (
    ${TableConst.kId} INTEGER PRIMARY KEY,
    ${TableConst.kRepoName} TEXT,
    ${TableConst.kOwnerName} TEXT,
    ${TableConst.kOwnerId} INTEGER,
    ${TableConst.kAvartar} TEXT,
    ${TableConst.kStarCount} INTEGER,
    ${TableConst.kContent} TEXT,
    ${TableConst.kPushedAt} TEXT
    )
 ''');

    batch.execute('''
    CREATE TABLE ${TableConst.kGitResultTableName}
    (
    ${TableConst.kId} INTEGER PRIMARY KEY,
    ${TableConst.kRepoName} TEXT,
    ${TableConst.kOwnerName} TEXT,
    ${TableConst.kOwnerId} INTEGER,
    ${TableConst.kAvartar} TEXT,
    ${TableConst.kStarCount} INTEGER,
    ${TableConst.kContent} TEXT,
    ${TableConst.kPushedAt} TEXT
    )
 ''');
  }
}
