import 'package:dubai_local/controllers/search_controller.dart';
import 'package:dubai_local/utils/localisations/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/localisations/images_paths.dart';

class SearchUi extends StatelessWidget {
  const SearchUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchController controller = Get.find();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
              children: [
                Image.asset(ImagesPaths.app_logo_d)
                    .w(Get.width * .5).marginOnly(top: 25),

                "Search Results"
                    .text
                    .color(Colors.white)
                    .size(20)
                    .make()
                    .pOnly(top: 30, bottom: 20),
                Container(
                  width: Get.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 45,
                          width: Get.width * .83,
                          child: TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              hintText: "Try 'Asian Cuisine' or 'Mobile shop'",
                              hintStyle: const TextStyle(
                                  fontSize: 13, color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),

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

    Widget items({required SearchItems searchItems}) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Container(
          width: Get.width * .8,
          height: 135,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(15)),
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
                        child: Image.network("${searchItems.itemsImages}",
                            fit: BoxFit.cover)),
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
                                child: "${searchItems.title}"
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
                                      child: "${searchItems.ratingValue}"
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
                              "${searchItems.phoneNumber}"
                                  .text
                                  .color(Colors.grey.shade600)
                                  .make()
                                  .pOnly(left: 5)
                            ],
                          ).pOnly(right: 5)
                        ],
                      )).pOnly(bottom: 20),
                ],
              ),
            ],
          ).pOnly(
            top: 10,
          ),
        ),
      );
    }
}
