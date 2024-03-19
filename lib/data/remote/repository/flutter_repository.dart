

import '../model/git_repository_response.dart';

abstract class FlutterRepository {
  Future<GitRepositoryResponse>getGitRepoResponse({int? perPage,required int page});
}
