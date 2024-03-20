import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_flutter_repositories/data/remote/model/git_repository_response.dart';
import 'package:top_flutter_repositories/ui/feature/git_repository_list/repository_controller.dart';

import '../../../helpers/helper_functions.dart';
import '../../custom_widgets/circular_loader.dart';
import '../../custom_widgets/dialog_loader.dart';
import '../repo_details.dart/repo_details.dart';

class GitRepositoryListScreen extends StatefulWidget {
  const GitRepositoryListScreen({super.key});

  @override
  State<GitRepositoryListScreen> createState() => _GitRepositoryListScreenState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _GitRepositoryListScreenState extends State<GitRepositoryListScreen> {
  final repositoryControler = Get.put(RepositoryListController());
  ScrollController scrollController = ScrollController();
  RxInt hitCount = 1.obs;
  @override
  void initState() {

    //For Scrolling pagination
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
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
   showLoaderDialog(Get.context!);
    repositoryControler.getSearchResult((isSuccess) {
      Get.back();
      hitCount.value = repositoryControler.page.value;
    }, perPage: 10, page: repositoryControler.page.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Git Repository List'),
          actions: [
            PopupMenuButton<int>(
              initialValue: 0,
              icon:const Icon(Icons.sort),
              onSelected: (int item) {
                log('$item');
                if (item == 1) {
                  repositoryControler.items = repositoryControler.sortByStarCount(repositoryControler.items);
                }else if(item==2){
                    repositoryControler.items = repositoryControler.sortByDateTime(repositoryControler.items);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('By Star Count'),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text('By Date Time'),
                ),
              ],
            ),
          ],
        ),
        body: Obx(
         () {
            return   repositoryControler.items.isNotEmpty? Scrollbar(
              controller: scrollController,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                          children: [
                            Column(
                              children: [
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                                  shrinkWrap: true,
                                  itemCount: repositoryControler.items.length,
                                  itemBuilder: (context, index) {
                                    Item item = repositoryControler.items[index];
                                    return MaterialButton(
                                      onPressed: () {
                                          Get.to(()=>GitRepoDetails(ownerName: item.owner?.login??'' , repoName : item.name??''));
                                      },
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      padding: EdgeInsets.zero,
                                      
                                      child: ListTile(
                                        title: Text(item.fullName ?? ''),
                                        leading: Text(
                                          item.watchers! > 999 ? '${numberFormat(item.watchers ?? 0)}' : '${item.watchers}',
                                        ),
                                        trailing: Text(dateTimeFormat(item.pushedAt.toString())),
                                      ),
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
                
                ),
              )       :Center(child: const CircularLoader());
  })
    
    
        
        );
  }
}


