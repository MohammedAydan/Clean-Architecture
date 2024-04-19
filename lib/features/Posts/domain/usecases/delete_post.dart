import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failure.dart';
import 'package:learning/features/Posts/domain/repositories/posts_repository.dart';

class DeletePostUseCase {
  final PostsRepository repository;

  DeletePostUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(String id) async {
    return await repository.deletePost(id);
  }
}
