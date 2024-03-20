

import '../model/git_repository_response.dart';
import '../model/repo_details._response.dart';

abstract class FlutterRepository {
  Future<GitRepositoryResponse>getGitRepoResponse({int? perPage,required int page});
  Future<RepoDetails>getRepoDetails({required String owner,required String repoName});
}
