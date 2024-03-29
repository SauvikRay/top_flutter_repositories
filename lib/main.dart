import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/injector/injector.dart';
import 'data/local/dao/db_init.dart';
import 'ui/feature/git_repository_list/repository_list_screen.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  diSetup();
      DbSingleton.instance.create().then((value) {
        runApp(const MyApp());
      },);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Top Flutter Repositories',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GitRepositoryListScreen(),
    );
  }
}
