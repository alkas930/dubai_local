import 'package:dubai_local/controllers/home_controller.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/app_colors.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/more_controller.dart';
import '../utils/localisations/images_paths.dart';

class MoreUI extends StatelessWidget {
  const MoreUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MoreController controller = Get.find();
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagesPaths.img_bg),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderWidget(isBackEnabled: false),
            Container(
              height: Get.height * .8,
              width: Get.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    moreItems(
                        context: context,
                        title: "Explore Dubai",
                        icon: ImagesPaths.more_explore,
                        url: "https://dubailocal.ae/dubai-explore"),
                    Divider(),
                    moreItems(
                        context: context,
                        title: "Things To Do",
                        icon: ImagesPaths.more_things_to_do,
                        url: "https://dubailocal.ae/things-to-do-in-dubai"),
                    Divider(),
                    moreItems(
                        context: context,
                        title: "Blog",
                        icon: ImagesPaths.more_blog,
                        url: "https://blog.dubailocal.ae/"),
                    Divider(),
                    moreItems(
                        context: context,
                        title: "Important Phone Numbers",
                        icon: ImagesPaths.more_important_phone,
                        url: "https://dubailocal.ae/useful-numbers"),
                    Divider(),
                    moreItems(
                        context: context,
                        title: "Visit Website",
                        icon: ImagesPaths.more_visit_website,
                        url: "https://dubailocal.ae/"),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
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
      onTap: () =>
          Navigator.pushNamed(context, AppRoutes.webview, arguments: {"url":url}),
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
