import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:practical/routs/routes.dart';

import 'controllers/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.myRoutes,
      theme: ThemeData.light(), // Default theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode:
          themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
