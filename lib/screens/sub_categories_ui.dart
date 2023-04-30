import 'package:cached_network_image/cached_network_image.dart';
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

    return SafeArea(
      child: WillPopScope(
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
                          builder: (context) {
                            return GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.subCategoryList.length,
                                    itemBuilder: (_, int index) {
                                      return items(
                                          categoryItems: controller
                                              .subCategoryList[index]);
                                    },
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                            childAspectRatio: 10 / 6))
                                .marginOnly(top: 10, bottom: 30);
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget items({required SubcatData categoryItems}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 35,
            child: ScalableImageWidget.fromSISource(
              si: ScalableImageSource.fromSvgHttpUrl(
                  Uri.parse('${categoryItems.fullIcon}')),
              onLoading: (ctx) {
                return SizedBox(
                    child: CircularProgressIndicator(
                  color: AppColors.accentRipple,
                ));
              },
            ).pOnly(top: 10),
          ),
          // SvgPicture.network(
          //   "${categoryItems.fullIcon}",
          //   color: Colors.red,
          //   height: 35,
          //   placeholderBuilder: (context) => SizedBox(
          //     child: CircularProgressIndicator(
          //       color: AppColors.accentRipple,
          //     ),
          //   ),
          // ).pOnly(top: 10),
          ("${categoryItems.subCatName}")
              .text
              .color(Colors.grey.shade700)
              .overflow(TextOverflow.ellipsis)
              .size(8)
              .make(),
        ],
      ),
    ).onTap(() {
      printData(categoryItems.toJson().toString());
      HomeController homeController = Get.find();
      homeController.subCatBusinessSlug = categoryItems.slug ?? "";
      homeController.subBusiness = categoryItems.subCatName ?? "";
      homeController.openSubCategoryBusiness(homeController.lastIndex);
    });
  }
}
