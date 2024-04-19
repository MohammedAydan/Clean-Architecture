import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:learning/core/network/network_info.dart';
import 'package:learning/features/Posts/data/datasources/post_local_datasource.dart';
import 'package:learning/features/Posts/data/datasources/post_remote_datasource.dart';
import 'package:learning/features/Posts/data/repositories/post_repository_impl.dart';
import 'package:learning/features/Posts/domain/repositories/posts_repository.dart';
import 'package:learning/features/Posts/domain/usecases/add_post.dart';
import 'package:learning/features/Posts/domain/usecases/delete_post.dart';
import 'package:learning/features/Posts/domain/usecases/get_all_posts.dart';
import 'package:learning/features/Posts/domain/usecases/update_post.dart';
import 'package:learning/features/Posts/presentation/controllers/manage_posts_controller.dart';
import 'package:learning/features/Posts/presentation/controllers/show_posts_controller.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // features = posts

  // controllers = show_posts_controller, manage_posts_controller
  sl.registerFactory(() => ShowPostsController(getAllPostsUsecase: sl()));
  sl.registerFactory(() => ManagePostsController(
        addPostUsecase: sl(),
        updatePostUsecase: sl(),
        deletePostUseCase: sl(),
      ));

  // usecases = get_all_posts, add_post, update_post, delete_post
  sl.registerLazySingleton(() => GetAllPostsUsecase(repository: sl()));
  sl.registerLazySingleton(() => AddPostUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl()));

  // repositories = posts_repository
  sl.registerLazySingleton<PostsRepository>(() => PostRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  // data_sources = posts_local_data_source, posts_remote_data_source
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(
        client: sl(),
      ));
  sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImpl(
        getStorage: sl(),
      ));

  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // external
  sl.registerLazySingleton(() => GetStorage.init());
  sl.registerLazySingleton(() => GetStorage());
  sl.registerLazySingleton(() => GetConnect());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
