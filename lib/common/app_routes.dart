import 'package:get/get.dart';
import 'package:learning/features/Posts/presentation/screens/add_post_screen.dart';
import 'package:learning/features/Posts/presentation/screens/show_post_screen.dart';
import 'package:learning/features/Posts/presentation/screens/show_posts_screen.dart';
import 'package:learning/features/Posts/presentation/screens/update_post_screen.dart';

class AppRoutes {
  static const String root = "/";

  static final List<GetPage> _pages = [
    GetPage(
      name: ShowPostsScreen.routeName,
      page: () => const ShowPostsScreen(),
    ),
    GetPage(
      name: ShowPostScreen.routeName,
      page: () => const ShowPostScreen(),
    ),
    GetPage(
      name: AddPostScreen.routeName,
      page: () => const AddPostScreen(),
    ),
    GetPage(
      name: UpdatePostScreen.routeName,
      page: () => const UpdatePostScreen(),
    ),
  ];

  static List<GetPage> get pages => _pages;
}
