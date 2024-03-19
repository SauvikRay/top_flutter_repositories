import '../model/git_repository_response.dart';

abstract class FlutterRemoteDataSource {
  //Start
    Future<GitRepositoryResponse>getGitRepoResponse({int? perPage,required int page});
//End
}
