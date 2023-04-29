import 'package:cached_network_image/cached_network_image.dart';
import 'package:dubai_local/controllers/categories_controller.dart';
import 'package:dubai_local/controllers/home_controller.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/localisations/app_colors.dart';
import '../utils/localisations/images_paths.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    CategoriesController mainHomeController = Get.find();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Container(
              width: Get.width,
              child: Stack(
                children: [
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
                        return Image.asset(ImagesPaths.ic_send_enquiry).p(6);
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
            "Choose A Category"
                .text
                .color(Colors.white)
                .size(20)
                .make()
                .pOnly(top: 30, bottom: 20),
            Container(
              height: Get.height * .73,
              alignment: Alignment.bottomCenter,
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
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Stack(
                      children: [
                        GetBuilder<CategoriesController>(
                            id: mainHomeController.updateListKey,
                            builder: (context) {
                              return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: 8,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          childAspectRatio: 5 / 4,
                                          mainAxisSpacing: 20 / 2,
                                          crossAxisSpacing: 10),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkButton(
                                      width: 80,
                                      height: 60,
                                      backGroundColor: Colors.grey.shade300,
                                      borderRadius: 10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          index == 7
                                              ? Image.asset(
                                                  ImagesPaths.ic_more_svg,
                                                  height: 25,
                                                )
                                              : Container(
                                                  height: 25,
                                                  child: ScalableImageWidget
                                                      .fromSISource(
                                                    si: ScalableImageSource
                                                        .fromSvgHttpUrl(Uri.parse(
                                                            mainHomeController
                                                                .categoryList[
                                                                    index]
                                                                .fullIcon)),
                                                    onLoading: (ctx) {
                                                      return SizedBox(
                                                          child:
                                                              CircularProgressIndicator(
                                                        color: AppColors
                                                            .accentRipple,
                                                      ));
                                                    },
                                                  ),
                                                ),

                                          // SvgPicture.network(
                                          //         (mainHomeController
                                          //             .categoryList[index]
                                          //             .fullIcon),
                                          //         color: Colors.red,
                                          //         height: 25,
                                          //         placeholderBuilder:
                                          //             (context) => SizedBox(
                                          //                   child: CircularProgressIndicator(
                                          //                       color: AppColors
                                          //                           .accent),
                                          //                 )),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                              width: 70,
                                              height: 20,
                                              child: FittedBox(
                                                  child: (index == 7
                                                          ? "More"
                                                          : mainHomeController
                                                              .categoryList[
                                                                  index]
                                                              .name)
                                                      .text
                                                      .maxLines(1)
                                                      .color(
                                                          Colors.grey.shade700)
                                                      .overflow(
                                                          TextOverflow.ellipsis)
                                                      .make())),
                                        ],
                                      ),
                                      onTap: () {
                                        controller.subCatSlug =
                                            mainHomeController
                                                .categoryList[index].slug;

                                        controller.subCatName =
                                            mainHomeController
                                                .categoryList[index].name;
                                        if (index == 7) {
                                          controller.changeIndex(3);
                                        } else {
                                          controller.openSubCategory(
                                              controller.bottomIndex.value);
                                        }
                                      },
                                    );
                                  });
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 45,
                    width: Get.width * .83,
                    child: TextFormField(
                      decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: "Try 'Asian Cuisine' or 'Mobile shop'",
                          hintStyle:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                          focusColor: Colors.grey,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    child: "Top Food Junction in Dubai".text.semiBold.make(),
                  ).marginOnly(left: 10, top: 25),
                  ClipRect(
                    child: Container(
                      height: 140,
                      width: 140,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Column(
                        children: [
                          ClipRect(
                            child: Image.network(
                              "https://assets.architecturaldigest.in/photos/63733ec2a2dd6ea6560eb6da/16:9/pass/Ditas%20Interior%20Image%20-%201%20(8).png",
                              width: 140,
                              height: 120,
                              fit: BoxFit.contain,
                            ),
                          ),
                          "Purani Dilli Restaurant".text.red500.size(10).make()
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width,
                        height: 130,
                        child: Image.asset(
                          ImagesPaths.ic_explore_dubai,
                          fit: BoxFit.cover,
                        ),

                        // CachedNetworkImage(
                        //   imageUrl:
                        //       "https://amateurtraveler.com/wp-content/uploads/2021/02/Xline%20Dubai%20Marina%20Zipline.jpg",
                        //   fit: BoxFit.cover,
                        //   placeholder: (context, url) => SizedBox(
                        //     child: LinearProgressIndicator(
                        //       color: AppColors.accentRipple,
                        //       minHeight: 120,
                        //     ),
                        //   ),
                        //   errorWidget: (context, url, error) =>
                        //       const Icon(Icons.error),
                        // ),
                      ).onTap(() {
                        controller
                            .openWebView("https://dubailocal.ae/dubai-explore");
                      }),
                      SizedBox(
                          width: Get.width,
                          height: 130,
                          child: Image.asset(
                            ImagesPaths.ic_things_to_do,
                            fit: BoxFit.cover,
                          )

                          // CachedNetworkImage(
                          //   imageUrl:
                          //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOvT_h4saSuIC8Ptf8WEGB63G_PnOqABrqGQ&usqp=CAU",
                          //   fit: BoxFit.cover,
                          //   placeholder: (context, url) => SizedBox(
                          //     child: LinearProgressIndicator(
                          //       color: AppColors.accentRipple,
                          //       minHeight: 120,
                          //     ),
                          //   ),
                          //   errorWidget: (context, url, error) =>
                          //       const Icon(Icons.error),
                          // ),
                          ).onTap(() {
                        controller.openWebView(
                            "https://dubailocal.ae/things-to-do-in-dubai");
                        // Get.toNamed(AppRoutes.webview,
                        //     arguments:
                        //         "https://dubailocal.ae/dubai-explore");
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
