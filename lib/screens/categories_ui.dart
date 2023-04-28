import 'package:dubai_local/controllers/categories_controller.dart';
import 'package:dubai_local/models/all_categories_response_model.dart';
import 'package:dubai_local/utils/localisations/images_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/localisations/app_colors.dart';

class CategoriesUi extends StatelessWidget {
  const CategoriesUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoriesController controller = Get.find();

    return SafeArea(
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
                Center(
                  child: Image.asset(ImagesPaths.app_logo_d)
                      .w(Get.width * .5)
                      .marginOnly(top: 25),
                ).pOnly(top: 10),
                "Categories"
                    .text
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
                        GetBuilder<CategoriesController>(
                            id: controller.updateListKey,
                            builder: (context) {
                              return GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller.categoryList.length,
                                      itemBuilder: (_, int index) {
                                        return items(
                                            categoryItems:
                                                controller.categoryList[index]);
                                      },
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10,
                                              childAspectRatio: 10 / 6))
                                  .marginOnly(top: 10, bottom: 30);
                            }).pOnly(bottom: 48)
                      ],
                    ),
                  ),
                ),
              ],
            ).pOnly(left: 5, right: 5),
          ),
        ),
      ),
    );
  }

  Widget items({required AllCategoriesData categoryItems}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
          ).marginOnly(top: 10),
          // SvgPicture.network(
          //   categoryItems.fullIcon,
          //   // color: Colors.red,
          //   colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.srcIn),
          //   height: 35,
          //   placeholderBuilder: (context) => SizedBox(
          //     child: CircularProgressIndicator(
          //       color: AppColors.accentRipple,
          //     ),
          //   ),
          // ).pOnly(top: 10),
          Container(
              alignment: Alignment.center,
              child: categoryItems.name.text
                  .color(Colors.grey.shade700)
                  .maxLines(2)
                  .size(4)
                  .make()
                  .px(2)
                  .centered()),
        ],
      ),
    );
  }
}
