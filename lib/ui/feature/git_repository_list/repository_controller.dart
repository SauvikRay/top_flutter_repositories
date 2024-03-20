import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../data/remote/model/git_repository_response.dart';
import '../../../data/remote/repository/flutter_repositoryImpl.dart';

class RepositoryListController extends GetxController {
  RxList<Item> items = <Item>[].obs;
  final _repository = Get.put(FlutterRepositoryImpl());

  RxInt page = 1.obs;
  @override
  void onInit() {
    getSearchResult((isSuccess) {}, page: page.value);
    super.onInit();
  }

  void getSearchResult(Function(bool isSuccess) onSuccess, {int? perPage, required int page}) async {
    try {
      var response = await _repository.getGitRepoResponse(perPage: perPage, page: page);
      if (response.items?.isNotEmpty == true) {
        items.addAll(response.items  ?? []);
      }
      onSuccess(true);
    } catch (e) {
      onSuccess(false);
      if (kDebugMode) {
        log('Error : $e');
      }
    }
  }

  sortByStarCount(List<Item> itemList) {
    if (itemList.isNotEmpty) {
      itemList.sort(
        (a, b) => b.watchers!.compareTo(a.watchers!),
      );
      return itemList;
    }
    return [];
  }

  sortByDateTime(List<Item> itemList){
    if(itemList.isNotEmpty){
      itemList.sort((a, b) => b.pushedAt!.compareTo(a.pushedAt!),);
      return itemList;
    }return[];
  }
}
