import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/controllers/home_controller.dart';
import 'package:dubai_local/screens/categories_ui.dart';
import 'package:dubai_local/screens/detail_Ui.dart';
import 'package:dubai_local/screens/home_ui.dart';
import 'package:dubai_local/screens/more_ui.dart';
import 'package:dubai_local/screens/search_ui.dart';
import 'package:dubai_local/screens/sub_categories_ui.dart';
import 'package:dubai_local/screens/webview_screen_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';

import 'utils/localisations/images_paths.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagesPaths.img_bg),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Obx(() => homeController.bottomIndex.value == 1
                      ? const SearchUi()
                      : homeController.bottomIndex.value == 2
                          ? const HomeUI()
                          : homeController.bottomIndex.value == 3
                              ? const CategoriesUi()
                              : homeController.bottomIndex.value == 5
                                  ? const WebViewScreen()
                                  : homeController.bottomIndex.value == 6
                                      ? const SubCategoriesUI()
                                      : homeController.bottomIndex.value == 7
                                          ? const DetailUi()
                                          : const MoreUI()),
                ),
                Container(
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
                  child: Obx(() => Row(
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
                      )),
                )
              ],
            ),
          ),
        ),
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

enum NotificationSelected { notification, search, home, categories, more }
