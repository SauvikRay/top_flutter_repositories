import 'package:get/get.dart';
import '../datasource/allnews_remote_data_source.dart';
import '../datasource/allnews_remote_data_sourceImpl.dart';
import 'allnews_repository.dart';

class AllNewsRepositoryImpl implements AllNewsRepository {
  final AllNewsRemoteDataSource _dataSource = Get.put(AllNewsRemoteDataSourceImpl());

}
//End
