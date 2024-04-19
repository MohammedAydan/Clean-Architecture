import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:learning/core/error/exception.dart';
import 'package:learning/features/Posts/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<Unit> addPost(PostModel post);
  Future<List<PostModel>> getAllPosts();
  Future<PostModel> getPost(String id);
  Future<Unit> updatePost(PostModel post);
  Future<Unit> deletePost(String id);
}

const baseUrl = "https://jsonplaceholder.typicode.com/";

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final GetConnect client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> addPost(PostModel post) async {
    final body = {
      "title": post.title,
      "body": post.body,
    };

    final res = await client.post("${baseUrl}posts", body);
    if (res.status.code == 201 || res.status.code == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(String id) async {
    final res = await client.delete("${baseUrl}posts/$id");
    if (res.status.code == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    final res = await client.get(
      "${baseUrl}posts",
      // decoder: (data) => jsonDecode(data),
    );
    if (res.status.code == 200) {
      final List jsonData = res.body;
      final List<PostModel> postModels =
          jsonData.map((e) => PostModel.fromJson(e)).toList();
      return Future.value(postModels);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> getPost(String id) async {
    final res = await client.get(
      "${baseUrl}posts/$id",
      decoder: (data) => jsonDecode(data),
    );

    if (res.status.code == 200) {
      return PostModel.fromJson(res.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final postId = post.id;
    final body = {
      "title": post.title,
      "body": post.body,
    };

    final res = await client.patch("${baseUrl}posts/$postId", body);
    if (res.status.code == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
