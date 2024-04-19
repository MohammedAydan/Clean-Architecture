import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/features/Posts/domain/entities/post.dart';
import 'package:learning/features/Posts/presentation/controllers/manage_posts_controller.dart';

import '../widgets/loading_widget.dart';

class UpdatePostScreen extends GetView<ManagePostsController> {
  static const String routeName = '/updatePost';
  const UpdatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PostEntitiy post = Get.arguments;
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    TextEditingController titleController = TextEditingController(
      text: post.title,
    );
    TextEditingController bodyController = TextEditingController(
      text: post.body,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Post ${post.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  validator: (v) => v!.isEmpty ? "Title can't empty" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  controller: bodyController,
                  validator: (v) => v!.isEmpty ? "Title can't empty" : null,
                  maxLines: null,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          if (controller.valdateForm(globalKey)) {
                            controller.updatePost(
                              PostEntitiy(
                                id: post.id,
                                title: titleController.text.trim(),
                                body: titleController.text.trim(),
                              ),
                            );
                          }
                        },
                  child: controller.isLoading.value
                      ? const LoadingWidget()
                      : const Text('Update Post'),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
