// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/screens/home_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/home_controller.dart';
import '../controllers/main_home_controller.dart';
import '../utils/localisations/images_paths.dart';

class MainHomeUI extends StatelessWidget {
  const MainHomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainHomeController controller = Get.find();
    HomeController homeController = Get.find();

    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Constants.tabBarRadius),
              bottomRight: Radius.circular(Constants.tabBarRadius)),
          color: const Color(0xffeef1f8),
        ),
        width: Get.width,
        alignment: Alignment.center,
        height: Constants.tabBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            menuItem(
              isSelected: homeController.bottomIndex.value == 0,
              icon: ImagesPaths.ic_notification,
              title: "Notification",
              onTap: () {
                ToastContext().init(context);
                Toast.show("No New Notifications");
              },
            ),
            menuItem(
                isSelected: homeController.bottomIndex.value == 1,
                icon: ImagesPaths.ic_search,
                title: "Search",
                onTap: () {
                  HomeController homeController = Get.find();
                  homeController.changeIndex(1);
                }),
            menuItem(
                isSelected: homeController.bottomIndex.value == 2,
                icon: ImagesPaths.ic_home,
                title: "Home",
                isHighlighted: true,
                onTap: () {
                  HomeController homeController = Get.find();
                  homeController.changeIndex(2);
                }),
            menuItem(
                isSelected: homeController.bottomIndex.value == 3,
                icon: ImagesPaths.ic_category,
                title: "Categories",
                onTap: () {
                  HomeController homeController = Get.find();
                  homeController.changeIndex(3);
                }),
            menuItem(
                isSelected: homeController.bottomIndex == 4,
                icon: ImagesPaths.ic_more,
                title: "More",
                onTap: () {
                  HomeController homeController = Get.find();
                  homeController.changeIndex(4);
                }),
          ],
        ),
      ),
      body: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => HomeUI(),
            settings: settings,
          );
        },
      ),
    );
  }

  Widget menuItem(
      {required String icon,
      required String title,
      bool isHighlighted = false,
      bool isSelected = false,
      required Function onTap}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Transform.translate(
          offset: isHighlighted ? const Offset(0, -16) : const Offset(0, 0),
          child: CircleAvatar(
            backgroundColor: isHighlighted
                ? Color(Constants.themeColorRed)
                : Colors.transparent,
            radius: 25,
            child: Image.asset(
              icon,
              width: 20,
              color: isHighlighted ? Colors.white : null,
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 12,
              color: isSelected
                  ? Color(Constants.themeColorRed)
                  : Color(0xff333333),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
        )
      ],
    ).onTap(() => onTap());
  }
}
