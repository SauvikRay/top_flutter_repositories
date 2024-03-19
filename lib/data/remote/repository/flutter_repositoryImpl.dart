import 'package:get/get.dart';
import '../datasource/flutter_remote_data_source.dart';
import '../datasource/flutter_remote_data_sourceImpl.dart';
import '../model/git_repository_response.dart';
import 'flutter_repository.dart';

class FlutterRepositoryImpl implements FlutterRepository {
  final FlutterRemoteDataSource _dataSource = Get.put(AllNewsRemoteDataSourceImpl());
  @override
  Future<GitRepositoryResponse>getGitRepoResponse({int? perPage,required int page}){
    return _dataSource.getGitRepoResponse(perPage:perPage,page: page) ;
  }
}
//End
