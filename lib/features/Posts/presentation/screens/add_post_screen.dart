import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/features/Posts/domain/entities/post.dart';
import 'package:learning/features/Posts/presentation/controllers/manage_posts_controller.dart';
import 'package:learning/core/widgets/loading_widget.dart';

class AddPostScreen extends GetView<ManagePostsController> {
  static const String routeName = '/addPost';
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: globalKey,
          child: Obx(
            () => Column(
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
                  validator: (v) => v!.isEmpty ? "Body can't empty" : null,
                  maxLines: null,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          if (controller.valdateForm(globalKey)) {
                            controller.addPost(
                              PostEntitiy(
                                id: "null",
                                title: titleController.text.trim(),
                                body: titleController.text.trim(),
                              ),
                            );
                          }
                        },
                  child: controller.isLoading.value
                      ? const LoadingWidget()
                      : const Text('Add Post'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
