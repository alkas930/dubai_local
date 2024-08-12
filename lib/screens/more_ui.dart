import 'dart:ffi';

import 'package:dubai_local/main.dart';
import 'package:dubai_local/services/networking_services/endpoints.dart';
import 'package:dubai_local/theme_controller.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import '../utils/localisations/images_paths.dart';

class MoreUI extends StatefulWidget {
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

  @override
  State<MoreUI> createState() => _MoreUIState();
}

class _MoreUIState extends State<MoreUI> {
  final themedata = GetStorage();
  bool themechange = false;

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    Future<bool> _onWillPop() async {
      // Navigator.pop(context);
      widget.onBack();
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
            changeIndex: widget.changeIndex,
            returnToHome: widget.returnToHome,
            onBack: () {},
          ),
          Expanded(
            flex: 1,
            child: SizedBox.shrink(),
          ),
          Expanded(
            flex: 5,
            child: Obx(
              () => Container(
                decoration: BoxDecoration(
                  color: themeController.isDark.value
                      ? const Color.fromARGB(255, 36, 36, 36)
                      : Colors.white,
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
                    Divider(
                      color: Colors.grey,
                    ),
                    moreItems(
                        context: context,
                        title: "Things To Do",
                        icon: ImagesPaths.more_things_to_do,
                        url: Endpoints.ThingsToDo),
                    Divider(
                      color: Colors.grey,
                    ),
                    moreItems(
                        context: context,
                        title: "Blog",
                        icon: ImagesPaths.more_blog,
                        url: Endpoints.Blog),
                    Divider(
                      color: Colors.grey,
                    ),
                    moreItems(
                        context: context,
                        title: "Important Phone Numbers",
                        icon: ImagesPaths.more_important_phone,
                        url: Endpoints.UsefulNumbers),
                    Divider(
                      color: Colors.grey,
                    ),
                    moreItems(
                        context: context,
                        title: "Visit Website",
                        icon: ImagesPaths.more_visit_website,
                        url: Endpoints.BASE_URL),
                    Divider(
                      color: Colors.grey,
                      height: 10,
                    ),
                    SwitchListTile(
                      value: themechange,
                      onChanged: (v) {
                        setState(() {
                          themechange = v;
                          themeController.changeTheme();
                        });
                      },
                      title: Text("Change Theme"),
                    )
                  ]),
                ),
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
    ThemeController themeController = Get.put(ThemeController());
    return ListTile(
      tileColor: Colors.blueGrey.shade50,
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity(horizontal: -4, vertical: -3),
      onTap: () {
        // Navigator.pushNamed(context, AppRoutes.webview,
        //     arguments: {"url": url});
        widget.setArgs!({"url": url});
        widget.changeIndex!(7);
      },
      leading: SizedBox(
        width: 24,
        height: 24,
        child: Image.asset(
          icon,
          color: themeController.isDark.value
              ? Color.fromARGB(255, 165, 161, 161)
              : Colors.black,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
            color: themeController.isDark.value
                ? Color.fromARGB(255, 165, 161, 161)
                : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 12),
      ),
      trailing: SizedBox(
        width: 16,
        height: 16,
        child: Image.asset(
          ImagesPaths.arrow_right,
          color: themeController.isDark.value
              ? Color.fromARGB(255, 165, 161, 161)
              : Colors.black,
        ),
      ),
    );
  }
}
