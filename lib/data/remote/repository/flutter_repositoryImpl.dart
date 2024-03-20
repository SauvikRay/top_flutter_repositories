import 'package:get/get.dart';
import '../datasource/flutter_remote_data_source.dart';
import '../datasource/flutter_remote_data_sourceImpl.dart';
import '../model/git_repository_response.dart';
import '../model/repo_details._response.dart';
import 'flutter_repository.dart';

class FlutterRepositoryImpl implements FlutterRepository {
  final FlutterRemoteDataSource _dataSource = Get.put(AllNewsRemoteDataSourceImpl());
  @override
  Future<GitRepositoryResponse>getGitRepoResponse({int? perPage,required int page}){
    return _dataSource.getGitRepoResponse(perPage:perPage,page: page) ;
  }
  @override
  Future<RepoDetails>getRepoDetails({required String owner,required String repoName}){
    return _dataSource.getRepoDetails(owner: owner, repoName: repoName);
  }
}
//End
