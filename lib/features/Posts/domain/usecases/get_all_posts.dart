import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failure.dart';
import 'package:learning/features/Posts/domain/entities/post.dart';
import 'package:learning/features/Posts/domain/repositories/posts_repository.dart';

class GetAllPostsUsecase {
  final PostsRepository repository;

  GetAllPostsUsecase({required this.repository});

  Future<Either<Failure, List<PostEntitiy>>> call() async {
    return await repository.getAllPosts();
  }
}
