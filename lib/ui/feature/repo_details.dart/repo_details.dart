import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../helpers/helper_functions.dart';
import '../../custom_widgets/circular_loader.dart';
import 'repo_details_controller.dart';

class GitRepoDetails extends StatefulWidget {
  const GitRepoDetails({super.key,required this.ownerName,required this.repoName});
final String ownerName;
final String repoName;
  @override
  State<GitRepoDetails> createState() => _GitRepoDetailsState();
}

class _GitRepoDetailsState extends State<GitRepoDetails> {
  final detailsController = Get.put(RepoDetailsControler());

  @override
  void initState() {
    detailsController.getRepoDetails(owner: widget.ownerName,repoName: widget.repoName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(widget.ownerName),),
      body: Obx(
        (){
          return  detailsController.isLoading.value ? const Center(child: CircularLoader()) :
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                          
                            child: CachedNetworkImage(
                              key: UniqueKey(),
                              imageUrl: detailsController.repoDetails?.owner?.avatarUrl?? '',
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const Icon(Icons.image),
                              placeholder:(context, url)=> const CircularLoader(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              
              
                  SizedBox(height: 10,),
                  Text(detailsController.repoDetails?.owner?.login?? '',style:textTheme.headlineSmall,),
                  Text('${detailsController.repoDetails?.description}',style: textTheme.bodyMedium,),

                  SizedBox(height: 20,),

                  Text('Last Update : ${dateTimeFormat(detailsController.repoDetails?.pushedAt.toString()??'')}'),
              
                ],
              ),
            ));
        }
      ),
    );
  }
}