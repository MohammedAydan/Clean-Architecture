import 'package:flutter/material.dart';
import 'package:learning/features/Posts/presentation/controllers/show_posts_controller.dart';
import 'package:learning/features/Posts/presentation/widgets/post_card.dart';

class ListViewForPosts extends StatelessWidget {
  const ListViewForPosts({
    super.key,
    required this.controller,
  });

  final ShowPostsController controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await controller.getAllPosts(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: controller.posts[index]);
        },
      ),
    );
  }
}
