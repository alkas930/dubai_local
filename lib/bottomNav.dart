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
    return SafeArea(
      child: Scaffold(
          body: Container(
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
                  child: SizedBox(
                    height: Get.height,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height - 120,
                          child: Obx(() => homeController.bottomIndex.value == 1
                              ? const SearchUi()
                              : homeController.bottomIndex.value == 2
                                  ? const HomeUI()
                                  : homeController.bottomIndex.value == 3
                                      ? const CategoriesUi()
                                      : homeController.bottomIndex.value == 5
                                          ? const WebViewScreen()
                                          : homeController.bottomIndex.value ==
                                                  6
                                              ? const SubCategoriesUI()
                                              : homeController
                                                          .bottomIndex.value ==
                                                      7
                                                  ? const DetailUi()
                                                  : const MoreUI()),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: const Color(0xffeef1f8),
                          ),
                          width: Get.width,
                          alignment: Alignment.center,
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              menuItem(
                                  icon: ImagesPaths.ic_notification,
                                  title: "Notification",
                                  onTap: () {
                                    ToastContext().init(context);
                                    Toast.show("No New Notifications");
                                  }),
                              menuItem(
                                  icon: ImagesPaths.ic_search,
                                  title: "Search",
                                  onTap: () {
                                    HomeController homeController = Get.find();
                                    homeController.changeIndex(1);
                                  }),
                              menuItem(
                                  icon: ImagesPaths.ic_home,
                                  title: "Home",
                                  isHighlighted: true,
                                  onTap: () {
                                    HomeController homeController = Get.find();
                                    homeController.changeIndex(2);
                                  }),
                              menuItem(
                                  icon: ImagesPaths.ic_category,
                                  title: "Categories",
                                  onTap: () {
                                    HomeController homeController = Get.find();
                                    homeController.changeIndex(3);
                                  }),
                              menuItem(
                                  icon: ImagesPaths.ic_more,
                                  title: "More",
                                  onTap: () {
                                    HomeController homeController = Get.find();
                                    homeController.changeIndex(4);
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  )))),
    );
  }

  Widget menuItem(
      {required String icon,
      required String title,
      bool isHighlighted = false,
      required Function onTap}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          backgroundColor: isHighlighted ? Colors.red : Colors.transparent,
          child: Image.asset(
            icon,
            width: 25,
            color: isHighlighted ? Colors.white : null,
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 4),
        )
      ],
    ).onTap(() {
      onTap();
    });
  }
}

enum NotificationSelected { notification, search, home, categories, more }
