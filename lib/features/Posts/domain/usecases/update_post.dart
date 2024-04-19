import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failure.dart';
import 'package:learning/features/Posts/domain/entities/post.dart';
import 'package:learning/features/Posts/domain/repositories/posts_repository.dart';

class UpdatePostUsecase {
  final PostsRepository repository;

  UpdatePostUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(PostEntitiy post) async {
    return await repository.updatePost(post);
  }
}
