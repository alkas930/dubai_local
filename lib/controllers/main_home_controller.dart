import 'package:dubai_local/screens/categories_ui.dart';
import 'package:dubai_local/screens/more_ui.dart';
import 'package:dubai_local/screens/search_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/all_categories_response_model.dart';
import '../screens/home_ui.dart';
import '../utils/localisations/images_paths.dart';

class MainHomeController extends SuperController {
  PersistentTabController navController =
      PersistentTabController(initialIndex: 2);
  List<AllCategoriesData> categoryList = [];
  String updateListKey = "updateListKey";

  List<Widget> buildScreens() {
    return [
      Center(
        child: "No New Notifications".text.make(),
      ),
      const SearchUi(),
      HomeUI(),
      const CategoriesUi(),
      const MoreUI(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.black,
          icon: Image.asset(
            ImagesPaths.ic_notification,
            height: 40,
            width: 40,
          ),
          title: "Notification"),
      PersistentBottomNavBarItem(
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.black,
          icon: Image.asset(ImagesPaths.ic_search),
          title: "Search"),
      PersistentBottomNavBarItem(
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.black,
          inactiveIcon: const Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          icon: Image.asset(
            ImagesPaths.ic_home,
            height: 20,
            width: 20,
          ),
          title: "Home"),
      PersistentBottomNavBarItem(
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.black,
          icon: Image.asset(ImagesPaths.ic_category),
          title: "Category"),
      PersistentBottomNavBarItem(
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.black,
          icon: Image.asset(ImagesPaths.ic_more),
          title: "More"),
    ];
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
