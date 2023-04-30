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

    Widget getScreen() {
      switch (homeController.bottomIndex.value) {
        case 1:
          return const SearchUi();
        case 2:
          return const HomeUI();
        case 3:
          return const CategoriesUi();
        case 4:
          return const MoreUI();
        case 5:
          return const WebViewScreen();
        case 6:
          return const SubCategoriesUI();
        case 7:
          return const DetailUi();
        default:
          return const HomeUI();
      }
    }

    return Stack(
      children: <Widget>[
        Image.asset(
          ImagesPaths.img_bg,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Obx(() => getScreen()),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Constants.tabBarRadius),
                    bottomRight: Radius.circular(Constants.tabBarRadius)),
                color: const Color(0xffeef1f8),
              ),
              alignment: Alignment.center,
              height: Constants.tabBarHeight,
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
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
            ),
          ),
        ),
      ],
    );
  }

  Widget menuItem(
      {required String icon,
      required String title,
      bool isHighlighted = false,
      bool isSelected = false,
      required Function onTap}) {
    return Container(
      width: (Get.width - 16) / 5,
      // decoration: BoxDecoration(color: Colors.red),
      child: Column(
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
      ),
    ).onTap(() => onTap());
  }
}

enum NotificationSelected { notification, search, home, categories, more }
