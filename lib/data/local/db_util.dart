import 'package:sqflite/sqflite.dart';
import 'package:top_flutter_repositories/data/local/dao/db_init.dart';

  class DbUtil {
  Future<int> saveData(String tableName, Map<String, Object?> data) => DbSingleton.instance.db.insert(tableName, data, conflictAlgorithm: ConflictAlgorithm.fail);
  Future<List<Map<String, dynamic>>> getAllListData(String tableName, [int? limit, int? offset]) => DbSingleton.instance.db.query(tableName, limit: limit, offset: offset);
  Future<List<Map<String, dynamic>>> getDataByID({required String tableName, required String where, required String id}) => DbSingleton.instance.db.query(tableName, where: where, whereArgs: [id]);
  Future<List<Map<String, dynamic>>> queryString(String query) => DbSingleton.instance.db.rawQuery(query);
  Future<int> deleteData({required String table, required String where, required String id}) => DbSingleton.instance.db.delete(table, where: where, whereArgs: [id]);

  Future<void> insertBatchData({required String table, required List<dynamic> entities}) => DbSingleton.instance.db.transaction(
        (txn) async {
          for (final entity in entities) {
            txn.insert(table, entity.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
          }
        },
      );

  Future<void>clearDatabase(String tableName)=>DbSingleton.instance.db.transaction((txn)async{
    txn.delete(tableName);
  });
}
