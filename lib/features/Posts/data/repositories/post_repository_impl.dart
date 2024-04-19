import 'package:dartz/dartz.dart';
import 'package:learning/core/error/exception.dart';
import 'package:learning/core/error/failure.dart';
import 'package:learning/core/network/network_info.dart';
import 'package:learning/features/Posts/data/datasources/post_local_datasource.dart';
import 'package:learning/features/Posts/data/datasources/post_remote_datasource.dart';
import 'package:learning/features/Posts/data/models/post_model.dart';
import 'package:learning/features/Posts/domain/entities/post.dart';
import 'package:learning/features/Posts/domain/repositories/posts_repository.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostRepositoryImpl implements PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> addPost(PostEntitiy post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );

    return await _getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(String id) async {
    return await _getMessage(() {
      return remoteDataSource.deletePost(id);
    });
  }

  @override
  Future<Either<Failure, List<PostEntitiy>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cashePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCashedPosts();
        return Right(localPosts);
      } on EmptyCasheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, PostEntitiy>> getPost(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePost = await remoteDataSource.getPost(id);
        localDataSource.cashePost(remotePost);
        return Right(remotePost);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPost = await localDataSource.getCashedPost(id);
        return Right(localPost);
      } on EmptyCasheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntitiy post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
    DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailuer());
    }
  }
}
