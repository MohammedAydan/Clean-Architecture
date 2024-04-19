import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/features/Posts/domain/entities/post.dart';
import 'package:learning/features/Posts/presentation/controllers/manage_posts_controller.dart';
import 'package:learning/features/Posts/presentation/screens/update_post_screen.dart';
import 'package:learning/features/Posts/presentation/widgets/loading_widget.dart';

class ShowPostScreen extends GetView<ManagePostsController> {
  static const String routeName = '/showPost';
  const ShowPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostEntitiy post = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details ${post.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              post.body,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Get.toNamed(UpdatePostScreen.routeName, arguments: post);
                  },
                  icon: const Icon(Icons.edit_rounded),
                  label: const Text("Edit"),
                ),
                Obx(
                  () => ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            controller.deletePost(post.id);
                          },
                    icon: controller.isLoading.value
                        ? const LoadingWidget()
                        : const Icon(Icons.delete_rounded),
                    label: const Text("Delete"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
