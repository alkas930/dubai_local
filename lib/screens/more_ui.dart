import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/app_colors.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      moreItems(
                          title: "Explore Dubai",
                          leadingIcon: Icon(
                            Icons.explore,
                            size: 30,
                            color: AppColors.fadedBlack,
                          ),
                          controller: controller),
                      moreItems(
                          title: "Things To Do",
                          leadingIcon: Icon(
                            Icons.graphic_eq_outlined,
                            size: 30,
                            color: AppColors.fadedBlack,
                          ),
                          controller: controller),
                      moreItems(
                          title: "Blog",
                          leadingIcon: Icon(
                            Icons.format_align_center_outlined,
                            size: 30,
                            color: AppColors.fadedBlack,
                          ),
                          controller: controller),
                    ],
                  ),
                ),
              ],
            ).pOnly(left: 5, right: 5),
          ),
        ),
      ),
    );
  }

  Widget moreItems(
      {required String title,
      required Icon leadingIcon,
      required MoreController controller}) {
    return ListTile(
      onTap: () {
        controller.moreOnWebView();
        printData("message");
      },
      leading: leadingIcon,
      title: title.text.size(15).make(),
      trailing: Icon(
        Icons.chevron_right,
        size: 50,
        color: AppColors.fadedBlack,
      ),
    );
  }
}
