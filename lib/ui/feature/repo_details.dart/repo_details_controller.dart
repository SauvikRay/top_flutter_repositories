import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../data/local/db_util.dart';
import '../../../data/local/model/database_response.dart';
import '../../../data/remote/model/repo_details._response.dart';
import '../../../data/remote/repository/flutter_repositoryImpl.dart';
import '../git_repository_list/db.dart';

class RepoDetailsControler extends GetxController{
    final _db = GetAllRepoItemDao(dbUtil: DbUtil());
  final _repository = Get.put(FlutterRepositoryImpl());

  RxBool isLoading=true.obs;
  DatabaseItem ? repoDetails;


 getRepoDetails({required String owner,required String repoName,required int id})async{
    try{
      List<DatabaseItem> details=await _db.getDetailsDataById(id);
      if( details.isNotEmpty){
        log(details[0].description.toString());
        repoDetails=details[0];
         isLoading.value=false;
      }else{

      final response = await _repository.getRepoDetails(owner: owner ,repoName: repoName);
      if(response.owner !=null){
        
        isLoading.value=false;
        final dataItem=DatabaseItem(id: response.id,repoName: response.name,ownerName:response.owner?.login??'', ownerId: response.owner?.id??0,avarterId: response.owner?.avatarUrl??'',description: response.description,starCount: response.stargazersCount,pushedAt: response.pushedAt.toString());
          repoDetails=dataItem;
          _db.saveDetailsPost([dataItem]);
      }
      log(response.toString());
      }
    }catch(e){
      if(kDebugMode){
        log('Error $e');
      }
    }
 }
}