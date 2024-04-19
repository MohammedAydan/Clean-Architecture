import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learning/core/error/exception.dart';
import 'package:learning/features/Posts/data/models/post_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCashedPosts();
  Future<PostModel> getCashedPost(String id);
  Future<Unit> cashePosts(List<PostModel> posts);
  Future<Unit> cashePost(PostModel post);
}

const CASHED_POSTS = "CASHED_POSTS";

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final GetStorage getStorage;

  PostLocalDataSourceImpl({required this.getStorage});

  @override
  Future<Unit> cashePost(PostModel post) {
    getStorage.write(post.id, jsonEncode(post.toJson()));
    return Future.value(unit);
  }

  @override
  Future<Unit> cashePosts(List<PostModel> posts) {
    // List<Map<String, dynamic>>
    List postModelsToJson = posts.map((e) => e.toJson()).toList();
    getStorage.write(CASHED_POSTS, jsonEncode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<PostModel> getCashedPost(String id) {
    final jsonString = getStorage.read(id);
    if (jsonString != null) {
      final jsonToPostModel = jsonDecode(jsonString);
      PostModel postModel = PostModel.fromJson(jsonToPostModel);
      return Future.value(postModel);
    } else {
      throw EmptyCasheException();
    }
  }

  @override
  Future<List<PostModel>> getCashedPosts() {
    final jsonString = getStorage.read(CASHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = jsonDecode(jsonString);
      List<PostModel> jsonToPostModel = decodeJsonData
          .map(
            (e) => PostModel.fromJson(e),
          )
          .toList();
      return Future.value(jsonToPostModel);
    } else {
      throw EmptyCasheException();
    }
  }
}
