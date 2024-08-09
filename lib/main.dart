import 'dart:ffi';

import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/my_theme.dart';
import 'package:dubai_local/theme_controller.dart';
import 'package:dubai_local/utils/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Await Firebase initialization
  await GetStorage.init();
  Get.put(ThemeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initialRoute,
      routes: AppPages.route,
    );
  }
}
