import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/controllers/home_controller.dart';
import 'package:dubai_local/screens/categories_ui.dart';
import 'package:dubai_local/screens/detail_Ui.dart';
import 'package:dubai_local/screens/home_ui.dart';
import 'package:dubai_local/screens/more_ui.dart';
import 'package:dubai_local/screens/search_ui.dart';
import 'package:dubai_local/screens/sub_categories_ui.dart';
import 'package:dubai_local/screens/webview_screen_ui.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';

import 'utils/localisations/images_paths.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    // HomeController homeController = Get.find();

    setScreen(index) => {
          setState(() {
            _currentIndex = index;
          })
        };

    Widget getScreen(String name) {
      switch (name) {
        case AppRoutes.main:
          switch (_currentIndex) {
            case 1:
              if (_navigatorKey.currentState!.canPop()) {
                _navigatorKey.currentState!.pop();
              }
              return const SearchUi();
            case 2:
              if (_navigatorKey.currentState!.canPop()) {
                _navigatorKey.currentState!.pop();
              }
              return HomeUI(changeIndex: (index) => setScreen(index));
            case 3:
              if (_navigatorKey.currentState!.canPop()) {
                _navigatorKey.currentState!.pop();
              }
              return const CategoriesUi();
            case 4:
              if (_navigatorKey.currentState!.canPop()) {
                _navigatorKey.currentState!.pop();
              }
              return const MoreUI();
            default:
              if (_navigatorKey.currentState!.canPop()) {
                _navigatorKey.currentState!.pop();
              }
              return HomeUI(changeIndex: (index) => setScreen(index));
          }
        case AppRoutes.subCategories:
          return const SubCategoriesUI();
        case AppRoutes.detail:
          return const DetailUi();
        case AppRoutes.webview:
          return const WebViewScreen();
        default:
          return HomeUI(changeIndex: (index) => setScreen(index));
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
            body: WillPopScope(
              onWillPop: () async {
                if (_navigatorKey.currentState!.canPop()) {
                  _navigatorKey.currentState!.pop();
                  return false;
                }
                return true;
              },
              child: Navigator(
                key: _navigatorKey,
                onGenerateRoute: (settings) {
                  printInfo(info: settings.toString());
                  return MaterialPageRoute(
                    builder: (BuildContext context) => SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: getScreen(settings.name!),
                          ),
                        ],
                      ),
                    ),
                    settings: settings,
                  );
                },
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
                  ),
                  menuItem(
                      isSelected: _currentIndex == 1,
                      icon: ImagesPaths.ic_search,
                      title: "Search",
                      onTap: () => setScreen(1)),
                  menuItem(
                      isSelected: _currentIndex == 2,
                      icon: ImagesPaths.ic_home,
                      title: "Home",
                      isHighlighted: true,
                      onTap: () => setScreen(2)),
                  menuItem(
                      isSelected: _currentIndex == 3,
                      icon: ImagesPaths.ic_category,
                      title: "Categories",
                      onTap: () => setScreen(3)),
                  menuItem(
                      isSelected: _currentIndex == 4,
                      icon: ImagesPaths.ic_more,
                      title: "More",
                      onTap: () => setScreen(4)),
                ],
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
                fontSize: 10,
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
