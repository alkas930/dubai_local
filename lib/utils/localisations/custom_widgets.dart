
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'app_colors.dart';

void printData( String message) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(message).forEach((match) {
    if (kDebugMode) {
      print(match.group(0));
    }
  });
}

Widget InkButton({
  double borderRadius = 30,
  double? height,
  double? width,
  Color backGroundColor = Colors.grey,
  Color? rippleColor,
  required Widget child,
  required Function onTap,
}) {
  return Material(

    borderRadius: BorderRadius.circular(borderRadius ),
    color: backGroundColor,
    child: InkWell(

      splashColor: rippleColor ?? AppColors.accentRipple,
      borderRadius: BorderRadius.circular(borderRadius ?? 30),
      onTap: () {
        onTap();
      },
      child: Container(
          alignment: Alignment.center,
          height: height?? 52,
          width: width ?? Get.width * .9,
          child: child),
    ),
  );
}

void snackBar({required String title, required String message}) {
  GetSnackBar(
    borderRadius: 10,
    borderColor: AppColors.accent,
    titleText: title.text
        .color(AppColors.white)
        .size(20)
        .fontWeight(FontWeight.bold)
        .make(),
    snackStyle: SnackStyle.FLOATING,
    messageText: message.text.color(AppColors.white).size(14).make(),
    backgroundColor: AppColors.fadedBlack,
    duration: const Duration(seconds: 2),
    snackPosition: SnackPosition.TOP,
  ).show();
}

void printValue(message) {
  if (kDebugMode) {
    print(message);
  }
}
