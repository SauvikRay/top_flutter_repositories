import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:top_flutter_repositories/data/remote/model/git_repository_response.dart';
import 'package:top_flutter_repositories/ui/git_repository_list/repository_controller.dart';

class GitRepositoryListScreen extends StatefulWidget {
  const GitRepositoryListScreen({super.key});

  @override
  State<GitRepositoryListScreen> createState() => _GitRepositoryListScreenState();
}

class _GitRepositoryListScreenState extends State<GitRepositoryListScreen> {
  final repositoryControler = Get.put(RepositoryListController());
  ScrollController scrollController = ScrollController();
  RxInt hitCount = 1.obs;
  @override
  void initState() {
    scrollController.addListener(() {
      log('dsfsdfsdfsd');

      if (scrollController.position.pixels > 0.8 * scrollController.position.maxScrollExtent) {
        if (hitCount == repositoryControler.page) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              repositoryControler.page++;

              loadFromApiCall();
            },
          );
        }
      }
    });
    super.initState();
  }

  loadFromApiCall() {
    showDialog(
      barrierColor:Colors.transparent,
      context: Get.context!, barrierDismissible: false, builder: (ctx) => const Center(child: (CircularProgressIndicator())));
    repositoryControler.getSearchResult((isSuccess) {
      Get.back();
      hitCount.value = repositoryControler.page.value;
    }, perPage: 10, page: repositoryControler.page.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:const Text('Git Repository List')),
        body: Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: scrollController,
            physics:const BouncingScrollPhysics(),
            child: Obx(() {
              return repositoryControler.items.isNotEmpty
                  ? Column(
                      children: [
                        Column(
                          children: [
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                              shrinkWrap: true,
                              itemCount: repositoryControler.items.length,
                              itemBuilder: (context, index) {
                                Item item = repositoryControler.items[index];
                                return ListTile(
                                  title: Text(item.name ?? ''),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                            ),
                          ],
                        )
                      ],
                    )
                  : SizedBox(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, child: const Center(child: CircularProgressIndicator()));
            }),
          ),
        ));
  }
}
