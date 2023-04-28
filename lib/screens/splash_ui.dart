import 'package:dubai_local/utils/localisations/images_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashUI extends StatelessWidget {
  const SplashUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Image.asset(
            ImagesPaths.splash_img,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
