import 'package:cached_network_image/cached_network_image.dart';
import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/controllers/home_controller.dart';
import 'package:dubai_local/controllers/sub_category_controller.dart';
import 'package:dubai_local/models/sub_categories_response_model.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:dubai_local/utils/localisations/images_paths.dart';
import 'package:dubai_local/utils/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/localisations/app_colors.dart';

class SubCategoriesUI extends StatelessWidget {
  const SubCategoriesUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SubCategoryController controller = Get.find();
    HomeController homeController = Get.find();

    Future<bool> _onWillPop() async {
      homeController.getBack();
      return false;
    }

    return WillPopScope(
        onWillPop: _onWillPop,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderWidget(isBackEnabled: true),
              // Row(
              //   children: [
              //
              //     Image.asset(
              //       ImagesPaths.app_logo_d,
              //       width: Get.width * .5,
              //     ).centered(),
              //   ],
              // ),
              homeController.subCatName.text
                  .color(Colors.white)
                  .size(20)
                  .make()
                  .pOnly(top: 30, bottom: 20),
              const SearchWidget(isLight: true),
              Container(
                height: 590,
                width: Get.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      GetBuilder<SubCategoryController>(
                          id: controller.updateListKey,
                          builder: (ctx) {
                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.subCategoryList.length,
                              itemBuilder: (_, int index) {
                                return items(
                                    context: context,
                                    categoryItem:
                                        controller.subCategoryList[index]);
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 5 / 4.5,
                                      mainAxisSpacing: 20 / 2,
                                      crossAxisSpacing: 10),
                            ).marginOnly(top: 10, bottom: 30);
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  Widget items(
      {required BuildContext context, required SubcatData categoryItem}) {
    return InkButton(
      rippleColor: Color(Constants.themeColorRed),
      backGroundColor: Color(0xffEEF2F3),
      borderRadius: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 35,
            child: ScalableImageWidget.fromSISource(
              si: ScalableImageSource.fromSvgHttpUrl(
                  Uri.parse(categoryItem.fullIcon!)),
              onLoading: (ctx) {
                return SizedBox(
                    child: CircularProgressIndicator(
                  color: AppColors.accentRipple,
                ));
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            categoryItem.subCatName!,
            style: const TextStyle(
              color: Color(0xff333333),
              fontSize: 10,
              overflow: TextOverflow.ellipsis,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      onTap: () {
        HomeController homeController = Get.find();
        homeController.subCatBusinessSlug = categoryItem.slug ?? "";
        homeController.subBusiness = categoryItem.subCatName ?? "";
        homeController.openSubCategoryBusiness(
            context, homeController.lastIndex);
      },
    );
  }
}
