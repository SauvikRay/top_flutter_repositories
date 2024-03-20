import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../data/remote/model/repo_details._response.dart';
import '../../../data/remote/repository/flutter_repositoryImpl.dart';

class RepoDetailsControler extends GetxController{
  final _repository = Get.put(FlutterRepositoryImpl());

  RxBool isLoading=true.obs;
  RepoDetails ? repoDetails;


 getRepoDetails({required String owner,required String repoName})async{
    try{
      final response = await _repository.getRepoDetails(owner: owner ,repoName: repoName);
      if(response.owner !=null){
        repoDetails=response;
        isLoading.value=false;
      }
      log(response.toString());
    }catch(e){
      if(kDebugMode){
        log('Error $e');
      }
    }
 }
}