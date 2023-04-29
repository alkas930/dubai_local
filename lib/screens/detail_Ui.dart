import 'package:cached_network_image/cached_network_image.dart';
import 'package:dubai_local/controllers/detail_controllers.dart';
import 'package:dubai_local/controllers/home_controller.dart';
import 'package:dubai_local/models/SubCategoryBusinessResponseModel.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/localisations/app_colors.dart';
import '../utils/localisations/images_paths.dart';

class DetailUi extends StatelessWidget {
  const DetailUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailController controller = Get.find();
    HomeController homeController = Get.find();
    Future<bool> _onWillPop() async {
      homeController.changeIndex(homeController.lastIndex);
      return false;
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
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
                  Column(
                    children: [
                      const HeaderWidget(isBackEnabled: true),
                      Obx(
                        () => controller.placeName.value.text
                            .color(Colors.white)
                            .size(20)
                            .make()
                            .pOnly(top: 30, bottom: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * .74,
                    child: GetBuilder<DetailController>(
                        id: controller.updateListKey,
                        builder: (context) {
                          return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.detailList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return items(
                                    searchItems: controller.detailList[index]);
                              });
                        }),
                  ).paddingOnly(bottom: 40),
                ],
              ).pOnly(left: 5, right: 5),
            ),
          ),
        ),
      ),
    );
  }

  Widget items({required SubcatBusinessData searchItems}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Container(
        width: Get.width * .8,
        height: 145,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: Get.width * .14,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: Image.network(searchItems.banner!,
                          errorBuilder: (_, __, ___) {
                        return Container(
                          child: "t".text.make(),
                        );
                      }, fit: BoxFit.cover)),
                ).pOnly(bottom: 50, left: 5),
                Container(
                    alignment: Alignment.topLeft,
                    width: Get.width * .80,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * .5,
                              child: "${searchItems.name}"
                                  .text
                                  .size(3)
                                  .color(Colors.grey.shade700)
                                  .fontWeight(FontWeight.w500)
                                  .make(),
                            ),
                            Container(
                              height: 30,
                              alignment: Alignment.topRight,
                              child: Row(
                                children: [
                                  VxRating(
                                    onRatingUpdate: (v) {},
                                    size: 10,
                                    normalColor: AppColors.grey,
                                    selectionColor: AppColors.yellow,
                                    count: 4,
                                    value: 3.4,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 16,
                                    width: Get.width * .13,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child:
                                        "${double.tryParse(searchItems.avgRating!) ?? 0.0.toStringAsFixed(1)}"
                                            .text
                                            .size(5)
                                            .color(Colors.white)
                                            .make(),
                                  )
                                ],
                              ),
                            )
                          ],
                        ).pOnly(left: 10, top: 10),
                        Container(
                          height: 1,
                          width: Get.width,
                          color: Colors.grey,
                        ).pOnly(top: 5, left: 10),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined,
                                size: 17, color: Colors.black),
                            SizedBox(
                              width: Get.width * .7,
                              child: "${searchItems.address}"
                                  .text
                                  .maxLines(2)
                                  .color(Colors.grey.shade600)
                                  .size(5)
                                  .make(),
                            ).pOnly(left: 5)
                          ],
                        ).pOnly(top: 10, right: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 17,
                              color: Colors.black,
                            ),
                            "${searchItems.phone}"
                                .text
                                .color(Colors.grey.shade600)
                                .make()
                                .pOnly(left: 5)
                          ],
                        ).pOnly(right: 5)
                      ],
                    )).pOnly(bottom: 20),
              ],
            )
          ],
        ).pOnly(
          top: 10,
        ),
      ),
    );
  }
}
