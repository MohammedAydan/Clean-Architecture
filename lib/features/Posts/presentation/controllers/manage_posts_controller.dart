import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/core/error/failure.dart';
import 'package:learning/core/strings/failure.dart';
import 'package:learning/features/Posts/domain/entities/post.dart';
import 'package:learning/features/Posts/domain/usecases/add_post.dart';
import 'package:learning/features/Posts/domain/usecases/delete_post.dart';
import 'package:learning/features/Posts/domain/usecases/update_post.dart';

class ManagePostsController extends GetxController {
  final AddPostUsecase addPostUsecase;
  final UpdatePostUsecase updatePostUsecase;
  final DeletePostUseCase deletePostUseCase;
  ManagePostsController({
    required this.addPostUsecase,
    required this.updatePostUsecase,
    required this.deletePostUseCase,
  });

  RxBool isLoading = false.obs;
  RxString title = "".obs;
  RxString body = "".obs;

  Future<void> addPost(PostEntitiy post) async {
    isLoading.value = true;
    final failureOrSuccess = await addPostUsecase.call(post);
    failureOrSuccess.fold(
      (failure) {
        errorHandler(_mapFailureToMessage(failure));
        isLoading.value = false;
      },
      (success) {
        isLoading.value = false;
        successHandler("Post added successfully");
      },
    );
  }

  Future<void> updatePost(PostEntitiy post) async {
    isLoading.value = true;
    final failureOrSuccess = await updatePostUsecase.call(post);
    failureOrSuccess.fold(
      (failure) {
        errorHandler(_mapFailureToMessage(failure));
        isLoading.value = false;
      },
      (success) {
        isLoading.value = false;
        successHandler("Post updated successfully");
      },
    );
  }

  Future<void> deletePost(String id) async {
    isLoading.value = true;
    final failureOrSuccess = await deletePostUseCase.call(id);
    failureOrSuccess.fold(
      (failure) {
        errorHandler(_mapFailureToMessage(failure));
        isLoading.value = false;
      },
      (success) {
        isLoading.value = false;
        successHandler("Post deleted successfully");
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

  void successHandler(String message) {
    Get.back();
    Get.snackbar(
      "Sucess",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void errorHandler(String error) {
    // Get.back();
    Get.snackbar(
      "Error",
      error,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  bool valdateForm(GlobalKey<FormState> globalKey) {
    final isValid = globalKey.currentState?.validate();
    if (isValid != null && isValid == true) {
      return true;
    } else {
      return false;
    }
  }
}
