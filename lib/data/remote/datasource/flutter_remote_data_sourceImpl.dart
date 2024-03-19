import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:top_flutter_repositories/data/remote/model/git_repository_response.dart';
import 'package:top_flutter_repositories/data/remote/network/api_endpoints.dart';

import '../core/base_remote_source.dart';
import 'flutter_remote_data_source.dart';

class AllNewsRemoteDataSourceImpl extends BaseRemoteSource with Endpoints implements FlutterRemoteDataSource {
 
 @override
 Future<GitRepositoryResponse> getGitRepoResponse( {int? perPage,required int page}) async{
      final quaryParams= {
        "q":"flutter",
        "page":page,
        "per_page": perPage??30,
        "sort":"",
        "order":"",
      };
 var dioCall = getRequest(getGitRepo, queryParams: quaryParams);
      try {
      var response = await callApiWithErrorParser(dioCall);

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("We received SearchResult data");
        }
      }
      return GitRepositoryResponse.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        log('Data Error : $e');
      }
      rethrow;
    }

  }
//End
}
