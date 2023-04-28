// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/main_home_controller.dart';

class MainHomeUI extends StatelessWidget {
  const MainHomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainHomeController controller = Get.find();

    return Scaffold(
      body: PersistentTabView(
        context,
        screens: controller.buildScreens(),
        controller: controller.navController,
        items: controller.navBarItems(),
        navBarStyle: NavBarStyle.style15,
        bottomScreenMargin: 5,
      ).pOnly(bottom: 10),
    );
  }
}
