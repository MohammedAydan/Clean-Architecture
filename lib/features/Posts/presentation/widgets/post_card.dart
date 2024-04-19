import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/features/Posts/domain/entities/post.dart';
import 'package:learning/features/Posts/presentation/screens/show_post_screen.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });
  final PostEntitiy post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(post.id),
        ),
        title: Text(post.title),
        subtitle: Text(post.body),
        onTap: () {
          Get.toNamed(ShowPostScreen.routeName, arguments: post);
        },
      ),
    );
  }
}
