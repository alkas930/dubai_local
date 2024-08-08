import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DemoController extends GetxController {
  // Declare the reactive variable
  RxBool isDarkTheme = false.obs;

  get themeModes => isDarkTheme.value;

  // Method to change the theme
  void changeTheme() {
    // Toggle the theme value
    isDarkTheme.value = !isDarkTheme.value;

    // Change the app's theme
    Get.changeTheme(
      isDarkTheme.value ? lightTheme : ThemeData.dark(),
    );
  }

  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
  );
}
