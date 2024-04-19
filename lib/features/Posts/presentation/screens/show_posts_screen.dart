import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/features/Posts/presentation/controllers/show_posts_controller.dart';
import 'package:learning/features/Posts/presentation/screens/add_post_screen.dart';
import 'package:learning/features/Posts/presentation/widgets/loading_widget.dart';
import '../widgets/list_view_for_posts.dart';

class ShowPostsScreen extends GetView<ShowPostsController> {
  static const String routeName = '/showPosts';
  const ShowPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Posts'),
      ),
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        bool isEmpty = controller.posts.isEmpty;
        if (isLoading) {
          return const LoadingWidget();
        }
        if (!isLoading && isEmpty && controller.error.isNotEmpty) {
          return Center(
            child: Text(controller.error.value),
          );
        }
        if (!isLoading && isEmpty) {
          return const Center(
            child: Text('No Posts Found'),
          );
        }
        return ListViewForPosts(controller: controller);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AddPostScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
