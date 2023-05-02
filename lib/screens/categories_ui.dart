import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/controllers/categories_controller.dart';
import 'package:dubai_local/controllers/home_controller.dart';
import 'package:dubai_local/models/all_categories_response_model.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:dubai_local/utils/localisations/images_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/splash_controller.dart';
import '../utils/localisations/app_colors.dart';
import '../utils/search_widget.dart';

class CategoriesUi extends StatelessWidget {
  const CategoriesUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SplashController controller = Get.find();
    HomeController homeController = Get.find();

    return SingleChildScrollView(
      child: Column(
        children: [
          const HeaderWidget(isBackEnabled: false),
          "Categories"
              .text
              .color(Colors.white)
              .size(20)
              .make()
              .pOnly(top: 30, bottom: 20),
          const SearchWidget(isLight: false),
          GetBuilder<CategoriesController>(
              id: controller.updateListKey,
              builder: (ctx) {
                return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.categoryList.length,
                        itemBuilder: (_, int index) {
                          return items(
                              context: context,
                              categoryItems: controller.categoryList[index],
                              homeController: homeController);
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 10 / 6))
                    .marginOnly(top: 10, bottom: 30);
              }).pOnly(bottom: 48),
        ],
      ),
    );
  }

  Widget items({
    required BuildContext context,
    required AllCategoriesData categoryItems,
    required HomeController homeController,
  }) {
    return InkButton(
      rippleColor: const Color(Constants.themeColorRed),
      backGroundColor: const Color(0xffEEF2F3),
      borderRadius: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 35,
            child: ScalableImageWidget.fromSISource(
              si: ScalableImageSource.fromSvgHttpUrl(
                  Uri.parse(categoryItems.fullIcon)),
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
            categoryItems.name,
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
        homeController.subCatSlug = categoryItems.slug;
        homeController.subCatName = categoryItems.name;
        homeController.openSubCategory(
          context,
          categoryItems.slug,
        );
      },
    );
  }
}
