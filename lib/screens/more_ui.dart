import 'package:dubai_local/controllers/home_controller.dart';
import 'package:dubai_local/services/networking_services/endpoints.dart';
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
      onTap: () => Navigator.pushNamed(context, AppRoutes.webview,
          arguments: {"url": url}),
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
