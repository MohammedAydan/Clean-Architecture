import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failure.dart';
import 'package:learning/features/Posts/domain/entities/post.dart';
import 'package:learning/features/Posts/domain/repositories/posts_repository.dart';

class GetPostUsecase {
  final PostsRepository repository;

  GetPostUsecase(this.repository);

  Future<Either<Failure, PostEntitiy>> call(String id) async {
    return await repository.getPost(id);
  }
}
