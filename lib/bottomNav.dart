import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/models/all_categories_response_model.dart';
import 'package:dubai_local/models/top_home_response_model.dart';
import 'package:dubai_local/screens/categories_ui.dart';
import 'package:dubai_local/screens/editProfile.dart';
import 'package:dubai_local/screens/listing.dart';
import 'package:dubai_local/screens/home_ui.dart';
import 'package:dubai_local/screens/main_business_ui.dart';
import 'package:dubai_local/screens/more_ui.dart';
import 'package:dubai_local/screens/my_profile.dart';
import 'package:dubai_local/screens/search_ui.dart';
import 'package:dubai_local/screens/sub_categories_ui.dart';
import 'package:dubai_local/screens/webview_screen_ui.dart';
import 'package:dubai_local/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import 'utils/localisations/images_paths.dart';
import 'dart:developer';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  Map _args = {};
  List<AllCategoriesData> categoryList = [];
  List<TopHomeData> topList = [];
  final _navigatorKey = GlobalKey<NavigatorState>();
  List<Map> _prevArgs = [];
  List<int> _prevIndex = [];
  int _currentIndex = 2;

  setScreen(index) {
    setState(() {
      _prevIndex.add(_currentIndex);
      _prevArgs.add(_args);
      _currentIndex = index;
    });
  }

  setArgs(args) {
    setState(() {
      _args = args;
    });
  }

  returnToHome() {
    if (_prevIndex.isNotEmpty) {
      setState(() {
        _prevArgs.removeLast();
        if (_prevArgs.isNotEmpty) _args = _prevArgs.last;
        _currentIndex = _prevIndex.last;
        _prevIndex.removeLast();
      });
      returnToHome();
    }
  }

  onBack() {
    print("SCREEN ADDED ");
    if (_prevIndex.isNotEmpty) {
      setState(() {
        _prevArgs.removeLast();
        if (_prevArgs.isNotEmpty) _args = _prevArgs.last;
        _currentIndex = _prevIndex.last;
        _prevIndex.removeLast();
      });
    } else {
      SystemNavigator.pop();
    }
  }

  // Widget getScreen(String name) {
  //   switch (name) {
  //     case AppRoutes.main:
  //       switch (_currentIndex) {
  //         case 1:
  //           if (_navigatorKey.currentState!.canPop()) {
  //             _navigatorKey.currentState
  //                 ?.popUntil(ModalRoute.withName(AppRoutes.main));
  //           }
  //           return const SearchUi();
  //         case 2:
  //           if (_navigatorKey.currentState!.canPop()) {
  //             _navigatorKey.currentState
  //                 ?.popUntil(ModalRoute.withName(AppRoutes.main));
  //           }
  //           return HomeUI(
  //             changeIndex: (index) => setScreen(index),
  //             topList: topList,
  //             categoryList: categoryList,
  //           );
  //         case 3:
  //           if (_navigatorKey.currentState!.canPop()) {
  //             _navigatorKey.currentState
  //                 ?.popUntil(ModalRoute.withName(AppRoutes.main));
  //           }
  //           return CategoriesUi(
  //             topList: topList,
  //             categoryList: categoryList,
  //           );
  //         case 4:
  //           if (_navigatorKey.currentState!.canPop()) {
  //             _navigatorKey.currentState
  //                 ?.popUntil(ModalRoute.withName(AppRoutes.main));
  //           }
  //           return const MoreUI();
  //         default:
  //           if (_navigatorKey.currentState!.canPop()) {
  //             _navigatorKey.currentState
  //                 ?.popUntil(ModalRoute.withName(AppRoutes.main));
  //           }
  //           return HomeUI(
  //               changeIndex: (index) => setScreen(index),
  //               categoryList: categoryList,
  //               topList: topList);
  //       }
  //     case AppRoutes.subCategories:
  //       return const SubCategoriesUI();
  //     case AppRoutes.detail:
  //       return const DetailUi();
  //     case AppRoutes.webview:
  //       return const WebViewScreen();
  //     case AppRoutes.mainBusiness:
  //       return MainBusinessUI();
  //     case AppRoutes.profile:
  //       return const MyProfile();
  //     default:
  //       return HomeUI(
  //         changeIndex: (index) => setScreen(index),
  //         topList: topList,
  //         categoryList: categoryList,
  //       );
  //   }
  // }

  Widget getScreenIndex() {
    switch (_currentIndex) {
      case 1:
        // if (_navigatorKey.currentState!.canPop()) {
        //   _navigatorKey.currentState
        //       ?.popUntil(ModalRoute.withName(AppRoutes.main));
        // }
        return SearchUi(
          returnToHome: returnToHome,
          onBack: onBack,
          setArgs: setArgs,
          args: _args,
          changeIndex: (index) => setScreen(index),
          topList: topList,
        );
      case 2:
        // if (_navigatorKey.currentState!.canPop()) {
        //   _navigatorKey.currentState
        //       ?.popUntil(ModalRoute.withName(AppRoutes.main));
        // }
        return HomeUI(
          returnToHome: returnToHome,
          onBack: onBack,
          changeIndex: (index) => setScreen(index),
          setArgs: setArgs,
          args: _args,
          topList: topList,
          categoryList: categoryList,
          toggleTheme: () {},
        );
      case 3:
        // if (_navigatorKey.currentState!.canPop()) {
        //   _navigatorKey.currentState
        //       ?.popUntil(ModalRoute.withName(AppRoutes.main));
        // }
        return CategoriesUi(
          returnToHome: returnToHome,
          onBack: onBack,
          setArgs: setArgs,
          args: _args,
          topList: topList,
          categoryList: categoryList,
          changeIndex: (index) => setScreen(index),
        );
      case 4:
        // if (_navigatorKey.currentState!.canPop()) {
        //   _navigatorKey.currentState
        //       ?.popUntil(ModalRoute.withName(AppRoutes.main));
        // }
        return MoreUI(
          returnToHome: returnToHome,
          onBack: onBack,
          setArgs: setArgs,
          args: _args,
          changeIndex: (index) => setScreen(index),
        );
      case 5:
        return SubCategoriesUI(
          returnToHome: returnToHome,
          onBack: onBack,
          setArgs: setArgs,
          args: _args,
          changeIndex: (index) => setScreen(index),
        );
      case 6:
        return DetailUi(
          returnToHome: returnToHome,
          onBack: onBack,
          setArgs: setArgs,
          args: _args,
          changeIndex: (index) => setScreen(index),
        );
      case 7:
        return WebViewScreen(
          returnToHome: returnToHome,
          onBack: onBack,
          setArgs: setArgs,
          args: _args,
          changeIndex: (index) => setScreen(index),
        );
      case 8:
        return MainBusinessUI(
          returnToHome: returnToHome,
          onBack: onBack,
          setArgs: setArgs,
          args: _args,
          changeIndex: (index) => setScreen(index),
          isBackEnabled: true,
        );
      case 9:
        return MyProfile(
          returnToHome: returnToHome,
          onBack: onBack,
          setArgs: setArgs,
          args: _args,
          changeIndex: (index) => setScreen(index),
        );
      case 10:
        return EditProfile(
          returnToHome: returnToHome,
          onBack: onBack,
          setArgs: setArgs,
          args: _args,
          changeIndex: (index) => setScreen(index),
        );
      default:
        // if (_navigatorKey.currentState!.canPop()) {
        //   _navigatorKey.currentState
        //       ?.popUntil(ModalRoute.withName(AppRoutes.main));
        // }
        return HomeUI(
          returnToHome: returnToHome,
          onBack: onBack,
          setArgs: setArgs,
          args: _args,
          changeIndex: (index) => setScreen(index),
          topList: topList,
          categoryList: categoryList,
          toggleTheme: () {},
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    log("RERENDER");

    final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    final double width = MediaQuery.of(context).size.width;

    if (args["categoryList"] != null && args["categoryList"]?.isNotEmpty) {
      categoryList = List<AllCategoriesData>.from(args["categoryList"]);
    }
    if (args["topList"] != null && args["topList"]?.isNotEmpty) {
      topList = List<TopHomeData>.from(args["topList"]);
    }
    print("HOME ARGS: ${args}");

    ThemeController themecontroller = Get.put(ThemeController());

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
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: getScreenIndex()),
                ),
                Obx(
                  () => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Constants.tabBarRadius),
                          bottomRight: Radius.circular(Constants.tabBarRadius)),
                      color: themecontroller.isDark.value
                          ? const Color.fromARGB(255, 36, 36, 36)
                          : Colors.white,
                    ),
                    alignment: Alignment.center,
                    height: Constants.tabBarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        menuItem(
                            isSelected: _currentIndex == 0,
                            icon: ImagesPaths.ic_notification,
                            title: "Notification",
                            onTap: () {
                              ToastContext().init(context);
                              Toast.show("No New Notifications");
                            },
                            width: width),
                        menuItem(
                            isSelected: _currentIndex == 1,
                            icon: ImagesPaths.ic_search,
                            title: "Search",
                            onTap: () {
                              setScreen(1);
                            },
                            width: width),
                        menuItem(
                            isSelected: _currentIndex == 2,
                            icon: ImagesPaths.ic_home,
                            title: "Home",
                            isHighlighted: true,
                            onTap: () {
                              setScreen(2);
                            },
                            width: width),
                        menuItem(
                            isSelected: _currentIndex == 3,
                            icon: ImagesPaths.ic_category,
                            title: "Categories",
                            onTap: () {
                              setScreen(3);
                            },
                            width: width),
                        menuItem(
                            isSelected: _currentIndex == 4,
                            icon: ImagesPaths.ic_more,
                            title: "More",
                            onTap: () {
                              setScreen(4);
                            },
                            width: width),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
    // return Stack(
    //   children: <Widget>[
    //     Image.asset(
    //       ImagesPaths.img_bg,
    //       height: MediaQuery.of(context).size.height,
    //       width: MediaQuery.of(context).size.width,
    //       fit: BoxFit.cover,
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(left: 8.0, right: 8.0),
    //       child: Scaffold(
    //         backgroundColor: Colors.transparent,
    //         extendBodyBehindAppBar: true,
    //         body: WillPopScope(
    //           onWillPop: () async =>
    //               !await _navigatorKey.currentState!.maybePop(),
    //           child: Navigator(
    //             key: _navigatorKey,
    //             onGenerateRoute: (settings) {
    //               log("SETTINGS: ${settings}");
    //               return MaterialPageRoute(
    //                 builder: (BuildContext context) => SafeArea(
    //                   child: Container(
    //                       // child: getScreen(settings.name!),
    //                       ),
    //                 ),
    //                 settings: settings,
    //               );
    //             },
    //           ),
    //         ),
    //         bottomNavigationBar: Container(
    //           margin: const EdgeInsets.only(bottom: 8),
    //           decoration: const BoxDecoration(
    //             borderRadius: BorderRadius.only(
    //                 bottomLeft: Radius.circular(Constants.tabBarRadius),
    //                 bottomRight: Radius.circular(Constants.tabBarRadius)),
    //             color: const Color(0xffeef1f8),
    //           ),
    //           alignment: Alignment.center,
    //           height: Constants.tabBarHeight,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               menuItem(
    //                   isSelected: _currentIndex == 0,
    //                   icon: ImagesPaths.ic_notification,
    //                   title: "Notification",
    //                   onTap: () {
    //                     ToastContext().init(context);
    //                     Toast.show("No New Notifications");
    //                   },
    //                   width: width),
    //               menuItem(
    //                   isSelected: _currentIndex == 1,
    //                   icon: ImagesPaths.ic_search,
    //                   title: "Search",
    //                   onTap: () {
    //                     setScreen(1);
    //                   },
    //                   width: width),
    //               menuItem(
    //                   isSelected: _currentIndex == 2,
    //                   icon: ImagesPaths.ic_home,
    //                   title: "Home",
    //                   isHighlighted: true,
    //                   onTap: () {
    //                     setScreen(2);
    //                   },
    //                   width: width),
    //               menuItem(
    //                   isSelected: _currentIndex == 3,
    //                   icon: ImagesPaths.ic_category,
    //                   title: "Categories",
    //                   onTap: () {
    //                     setScreen(3);
    //                   },
    //                   width: width),
    //               menuItem(
    //                   isSelected: _currentIndex == 4,
    //                   icon: ImagesPaths.ic_more,
    //                   title: "More",
    //                   onTap: () {
    //                     setScreen(4);
    //                   },
    //                   width: width),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget menuItem(
      {required String icon,
      required String title,
      bool isHighlighted = false,
      bool isSelected = false,
      required Function onTap,
      required double width}) {
    ThemeController themeController = Get.put(ThemeController());
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: (width - 16 - 32) / 5,
        // decoration: BoxDecoration(color: Colors.red),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Transform.translate(
              offset: isHighlighted ? const Offset(0, -12) : const Offset(0, 0),
              child: CircleAvatar(
                backgroundColor: isHighlighted
                    ? const Color(Constants.themeColorRed)
                    : Colors.transparent,
                radius: 25,
                child: Image.asset(
                  icon,
                  width: 20,
                  color: isHighlighted ? Colors.white : null,
                ),
              ),
            ),
            FittedBox(
              // fit: BoxFit.fitWidth,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 10,
                    color: themeController.isDark.value && isSelected
                        ? const Color.fromARGB(255, 207, 16, 16)
                        : isSelected
                            ? const Color(Constants.themeColorRed)
                            : const Color(0xff333333),
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum NotificationSelected { notification, search, home, categories, more }
