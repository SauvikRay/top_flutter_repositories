
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../remote/repository/flutter_repositoryImpl.dart';

final locator = GetIt.instance;

void diSetup() {
 

//all item
  locator.registerLazySingleton<FlutterRepositoryImpl>(
      () => Get.put(FlutterRepositoryImpl()));

}
