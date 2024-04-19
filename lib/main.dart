import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/common/app_routes.dart';
import 'package:learning/common/app_themes.dart';
import 'package:learning/features/Posts/presentation/controllers/manage_posts_controller.dart';
import 'package:learning/features/Posts/presentation/controllers/show_posts_controller.dart';
import 'package:learning/features/Posts/presentation/screens/show_posts_screen.dart';
import 'package:learning/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Get.put(di.sl<ShowPostsController>());
  Get.put(di.sl<ManagePostsController>());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Clean Architecture",
      debugShowCheckedModeBanner: false,
      theme: AppThemes.appTheme,
      darkTheme: AppThemes.darkAppTheme,
      themeMode: ThemeMode.dark,
      initialRoute: ShowPostsScreen.routeName,
      getPages: AppRoutes.pages,
    );
  }
}
