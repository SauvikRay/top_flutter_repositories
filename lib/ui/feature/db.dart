import 'dart:developer';

import 'package:top_flutter_repositories/constants/db_table_constants.dart';
import 'package:top_flutter_repositories/data/local/db_util.dart';
import 'package:top_flutter_repositories/data/local/model/save_time_response.dart';

import '../../data/local/model/database_response.dart';
import '../../data/remote/network/error_handlers.dart';

class GetAllRepoItemDao {
  final DbUtil _dbUtil;
  GetAllRepoItemDao({required DbUtil dbUtil}) : _dbUtil = dbUtil;
  Future<List<DatabaseItem>> getAllItemListData({int? limit, int? offset}) async {
    try {
      List<Map<String, dynamic>> resultData = await _dbUtil.getAllListData(TableConst.kGitResultTableName, limit, offset);
      return List.generate(resultData.length, (i) {
        return DatabaseItem.fromJson(resultData[i]);
      });
    } catch (e) {
      log(e.toString());
      throw handleError(e.toString());
    }
  }

  Future<List<DatabaseItem>> getDetailsDataById(int id) async {
    try {
      final result = await _dbUtil.getDataByID(tableName: TableConst.kDetailsTableName, id: id.toString(), where: "id = ?");
      return List.generate(result.length, (i) {
        return DatabaseItem.fromJson(result[i]);
      });
    } catch (e) {
      throw handleError(e.toString());
    }
  }

  Future<List<SaveTime>> getSavedTime(int id) async {
    try {
      final result = await _dbUtil.getDataByID(tableName: TableConst.kSaveTimeTable, id: id.toString(), where: "id = ?");
      return List.generate(result.length, (i) => SaveTime.fromJson(result[i]));
    } catch (e) {
      throw handleError(e.toString());
    }
  }

  void saveAllPost(List<DatabaseItem> items) {
    _dbUtil.insertBatchData(table: TableConst.kGitResultTableName, entities: items);
  }

  void saveDetailsPost(List<DatabaseItem> items) {
    _dbUtil.insertBatchData(table: TableConst.kDetailsTableName, entities: items);
  }

  void saveTimetoDatabase(List<SaveTime> times) {
    _dbUtil.insertBatchData(table: TableConst.kSaveTimeTable, entities: times);
  }

  void clearDataTable(){
    _dbUtil.clearDatabase(TableConst.kGitResultTableName);
    _dbUtil.clearDatabase(TableConst.kDetailsTableName);
    _dbUtil.clearDatabase(TableConst.kSaveTimeTable);
  }
}
