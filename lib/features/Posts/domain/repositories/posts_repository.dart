import 'package:learning/core/error/failure.dart';
import 'package:learning/features/Posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

abstract class PostsRepository {
  Future<Either<Failure, Unit>> addPost(PostEntitiy post);
  Future<Either<Failure, List<PostEntitiy>>> getAllPosts();
  Future<Either<Failure, PostEntitiy>> getPost(String id);
  Future<Either<Failure, Unit>> updatePost(PostEntitiy post);
  Future<Either<Failure, Unit>> deletePost(String id);
}
