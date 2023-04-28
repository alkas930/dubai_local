import 'package:cached_network_image/cached_network_image.dart';
import 'package:dubai_local/controllers/home_controller.dart';
import 'package:dubai_local/controllers/sub_category_controller.dart';
import 'package:dubai_local/models/sub_categories_response_model.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:dubai_local/utils/localisations/images_paths.dart';
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
        child: Scaffold(
          body: Container(
            height: Get.height,
            width: Get.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagesPaths.img_bg),
                fit: BoxFit.fill,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 35,
                        ).marginOnly(top: 25,left: 10).onTap(() {
                          homeController.getBack();
                        }),
                        Center(
                          child: Image.asset(ImagesPaths.app_logo_d)
                              .w(Get.width * .5)
                              .marginOnly(top: 25),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.red.shade700,
                          child: CachedNetworkImage(
                            imageUrl: "",
                            errorWidget: (_, __, ___) {
                              return Image.asset(ImagesPaths.ic_send_enquiry)
                                  .p(6);
                            },
                            placeholder: (_, __) {
                              return CircularProgressIndicator(
                                color: AppColors.accentRipple,
                              );
                            },
                          ),
                        ).marginOnly(top: 25).positioned(right: 10),
                      ],
                    ),
                  ),
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
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: Get.width * .85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white),
                    ),
                    child: SizedBox(
                      height: 45,
                      width: Get.width * .83,
                      child: TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          hintText: "Try 'Asian Cuisine' or 'Mobile shop'",
                          hintStyle:
                              const TextStyle(fontSize: 13, color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
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
              ).pOnly(left: 5, right: 5),
            ),
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
