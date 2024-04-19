import 'package:get/state_manager.dart';
import 'package:learning/core/error/failure.dart';
import 'package:learning/core/strings/failure.dart';
import 'package:learning/features/Posts/domain/entities/post.dart';
import 'package:learning/features/Posts/domain/usecases/get_all_posts.dart';

class ShowPostsController extends GetxController {
  final GetAllPostsUsecase getAllPostsUsecase;
  ShowPostsController({required this.getAllPostsUsecase});

  RxBool isLoading = true.obs;
  RxString error = "".obs;
  RxList<PostEntitiy> posts = <PostEntitiy>[].obs;

  Future<void> getAllPosts() async {
    final failuerOrPosts = await getAllPostsUsecase.call();
    failuerOrPosts.fold(
      (failure) {
        error.value = _mapFailureToMessage(failure);
        isLoading.value = false;
      },
      (psost) {
        posts.value = psost;
        error.value = "";
        isLoading.value = false;
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure():
        return SERVER_FAILUER_MESSAGE;
      case EmptyCacheFailure():
        return EMPTY_CASHE_FAILUER_MESSAGE;
      case OfflineFailuer():
        return OFFLINE_FAILUER_MESSAGE;
      default:
        return 'Unexpected error pleace try again later.';
    }
  }

  @override
  void onReady() {
    super.onReady();
    getAllPosts();
  }
}
