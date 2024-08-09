import 'dart:ffi';

import 'package:dubai_local/main.dart';
import 'package:dubai_local/services/networking_services/endpoints.dart';
import 'package:dubai_local/theme_controller.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../utils/localisations/images_paths.dart';

class MoreUI extends StatelessWidget {
  final Function(int index)? changeIndex;
  final Function(Map args)? setArgs;
  final Function() onBack;
  final Function() returnToHome;
  final Map args;

  MoreUI({
    Key? key,
    required this.changeIndex,
    required this.setArgs,
    required this.onBack,
    required this.returnToHome,
    required this.args,
  }) : super(key: key);

  final themedata = GetStorage();

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      // Navigator.pop(context);
      onBack();
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          HeaderWidget(
            isBackEnabled: false,
            changeIndex: changeIndex,
            returnToHome: returnToHome,
            onBack: () {},
          ),
          Expanded(
            flex: 1,
            child: SizedBox.shrink(),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  const SizedBox(
                    height: 20,
                  ),
                  moreItems(
                      context: context,
                      title: "Explore Dubai",
                      icon: ImagesPaths.more_explore,
                      url: Endpoints.ExploreDubai),
                  Divider(),
                  moreItems(
                      context: context,
                      title: "Things To Do",
                      icon: ImagesPaths.more_things_to_do,
                      url: Endpoints.ThingsToDo),
                  Divider(),
                  moreItems(
                      context: context,
                      title: "Blog",
                      icon: ImagesPaths.more_blog,
                      url: Endpoints.Blog),
                  Divider(),
                  moreItems(
                      context: context,
                      title: "Important Phone Numbers",
                      icon: ImagesPaths.more_important_phone,
                      url: Endpoints.UsefulNumbers),
                  Divider(),
                  moreItems(
                      context: context,
                      title: "Visit Website",
                      icon: ImagesPaths.more_visit_website,
                      url: Endpoints.BASE_URL),
                  Divider(
                    height: 10,
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget moreItems(
      {required BuildContext context,
      required String title,
      required String icon,
      required String url}) {
    return ListTile(
      tileColor: Colors.blueGrey.shade50,
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity(horizontal: -4, vertical: -3),
      onTap: () {
        // Navigator.pushNamed(context, AppRoutes.webview,
        //     arguments: {"url": url});
        setArgs!({"url": url});
        changeIndex!(7);
      },
      leading: SizedBox(
        width: 24,
        height: 24,
        child: Image.asset(icon),
      ),
      title: Text(
        title,
        style: TextStyle(
            color: Color(0xff333333),
            fontWeight: FontWeight.w500,
            fontSize: 12),
      ),
      trailing: SizedBox(
        width: 16,
        height: 16,
        child: Image.asset(ImagesPaths.arrow_right),
      ),
    );
  }
}
