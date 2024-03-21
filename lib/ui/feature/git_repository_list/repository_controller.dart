import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:top_flutter_repositories/data/injector/injector.dart';
import 'package:top_flutter_repositories/data/local/db_util.dart';
import 'package:top_flutter_repositories/data/remote/network/error_handlers.dart';

import '../../../data/local/model/database_response.dart';
import '../../../data/local/model/save_time_response.dart';
import '../../../data/remote/model/git_repository_response.dart';
import '../../../data/remote/repository/flutter_repositoryImpl.dart';
import '../db.dart';

class RepositoryListController extends GetxController {
  final _db = GetAllRepoItemDao(dbUtil: DbUtil());
  RxList<Item> items = <Item>[].obs;
  List<DatabaseItem> databaseItem=[];

  RxInt page = 1.obs;
  @override
  void onInit() {
    ceckTimeDifference(id: 1,now:DateTime.now()).then((value) {
    getSearchResult((isSuccess) {}, page: page.value);
    },);
    super.onInit();
  }

  void getSearchResult(Function(bool isSuccess) onSuccess, {int? perPage, required int page}) async {
    try {
      List<DatabaseItem> dataItems = await _db.getAllItemListData(limit: perPage, offset:(10 *page)-10);
      if (dataItems.isNotEmpty) {
        for(var item in dataItems){
        items.add(Item(id: item.id, name: item.repoName,owner: Owner(login: item.ownerName,avatarUrl: item.avarterId),stargazersCount: item.starCount,pushedAt: item.pushedAt));
        }
      } else {
        var response = await locator<FlutterRepositoryImpl>().getGitRepoResponse(perPage: perPage, page: page);
        if (response.items?.isNotEmpty == true) {
          items.addAll(response.items ?? []);
           
          for (var data in items){
              databaseItem.add(DatabaseItem(id: data.id,repoName: data.name,ownerId: data.owner?.id??0,ownerName: data.owner?.login??'',avarterId: data.owner?.avatarUrl??'',description: data.description,starCount: data.stargazersCount,pushedAt: data.pushedAt));
          }
          _db.saveAllPost(databaseItem);
          // databaseItem.clear();
        }
      }
      onSuccess(true);
    } catch (e) {
      onSuccess(false);
      log(e.toString());
    }
  }

  sortByStarCount(List<Item> itemList) {
    if (itemList.isNotEmpty) {
      itemList.sort(
        (a, b) => b.stargazersCount!.compareTo(a.stargazersCount!),
      );
      return itemList;
    }
    return [];
  }

  sortByDateTime(List<Item> itemList) {
    if (itemList.isNotEmpty) {
      itemList.sort(
        (a, b) => b.pushedAt!.compareTo(a.pushedAt!),
      );
      return itemList;
    }
    return [];
  }

 Future<void> ceckTimeDifference({required int id,required DateTime now})async{

      final savedTime=await _db.getSavedTime(id);
      if(savedTime.isNotEmpty){
        final diff = now.difference(DateTime.parse(savedTime[0].dateTime.toString()));
        if(diff.inMinutes>=2){
          _db.clearDataTable();
        }
      }else{
      final saveTime=SaveTime(id:1,dateTime: now.toString());
       _db.saveTimetoDatabase([saveTime]);
      }
  }
}
