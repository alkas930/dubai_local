import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/controllers/home_controller.dart';
import 'package:dubai_local/controllers/splash_controller.dart';
import 'package:dubai_local/services/networking_services/endpoints.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import 'package:dubai_local/utils/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/top_home_response_model.dart';
import '../utils/localisations/app_colors.dart';
import '../utils/localisations/images_paths.dart';

class HomeUI extends StatelessWidget {
  final Function(int index)? changeIndex;

  const HomeUI({Key? key, this.changeIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    SplashController mainHomeController = Get.find();

    Widget ListingCard({required TopHomeData data, required int index}) =>
        Stack(
          children: [
            Card(
              clipBehavior: Clip.hardEdge,
              elevation: 8,
              shadowColor: Colors.black,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                width: (Get.width / 3) - 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        if (data.res![index].icon != null) ...[
                          Image.network(
                            data.res![index].icon!,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          )
                        ],
                        Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                data.res![index].name!,
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(Constants.themeColorRed),
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    ImagesPaths.ic_location,
                                    scale: 12,
                                    color: const Color(0xff444444),
                                  ),
                                  Expanded(
                                    child: Text(
                                      data.res![index].name!,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff444444)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: InkButton(
                      rippleColor: Color.fromARGB(80, 255, 255, 255),
                      backGroundColor: Colors.transparent,
                      borderRadius: 10,
                      onTap: () {
                        if (data.source == "business") {
                          if (data.res![index].slug != null) {
                            controller.subCatBusinessSlug =
                                data.res![index].slug! ?? "";
                            controller.subBusiness =
                                data.res![index].slug! ?? "";
                            controller.openSubCategoryBusiness(context);
                          }
                        } else if (data.source == "blog") {
                          if (data.res![index].link != null)
                            Navigator.pushNamed(context, AppRoutes.webview,
                                arguments: {"url": data.res![index].link!});
                        }
                      },
                      child: SizedBox.shrink())),
            )
          ],
        );

    Widget WebviewBanner(String image, String url) => Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: SizedBox(
            width: Get.width,
            height: 130,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ).onTap(() {
          Navigator.pushNamed(context, AppRoutes.webview,
              arguments: {"url": url});
        });

    return SingleChildScrollView(
      // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const HeaderWidget(isBackEnabled: false),
          "Choose A Category"
              .text
              .color(Colors.white)
              .size(20)
              .make()
              .pOnly(top: 48, bottom: 0),
          Container(
            alignment: Alignment.topCenter,
            width: Get.width,
            constraints: BoxConstraints(minHeight: Get.height),
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
                  child: GetBuilder<SplashController>(
                      id: mainHomeController.updateListKey,
                      builder: (context) {
                        if (mainHomeController.categoryList.isNotEmpty) {
                          return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: 8,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 5 / 4.5,
                                      mainAxisSpacing: 20 / 2,
                                      crossAxisSpacing: 10),
                              itemBuilder: (BuildContext context, int index) {
                                return InkButton(
                                  rippleColor:
                                      const Color(Constants.themeColorRed),
                                  backGroundColor: const Color(0xffEEF2F3),
                                  borderRadius: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      index == 7
                                          ? Image.asset(
                                              ImagesPaths.ic_more_svg,
                                              height: 35,
                                            )
                                          : SizedBox(
                                              height: 35,
                                              child: ScalableImageWidget
                                                  .fromSISource(
                                                si: ScalableImageSource
                                                    .fromSvgHttpUrl(Uri.parse(
                                                        mainHomeController
                                                            .categoryList[index]
                                                            .fullIcon)),
                                                onLoading: (ctx) {
                                                  return SizedBox(
                                                      child:
                                                          CircularProgressIndicator(
                                                    color:
                                                        AppColors.accentRipple,
                                                  ));
                                                },
                                              ),
                                            ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        (() {
                                          if (index == 7) {
                                            return "More";
                                          } else {
                                            return mainHomeController
                                                .categoryList[index].name;
                                          }
                                        }()),
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
                                    controller.subCatSlug = mainHomeController
                                        .categoryList[index].slug;
                                    controller.subCatName = mainHomeController
                                        .categoryList[index].name;
                                    if (index == 7) {
                                      changeIndex!(3);
                                    } else {
                                      controller.openSubCategory(
                                        context,
                                        mainHomeController
                                            .categoryList[index].slug,
                                      );
                                    }
                                  },
                                );
                              });
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                ),
                const SearchWidget(isLight: true)
                    .marginOnly(top: 16, bottom: 16),
                GetBuilder<SplashController>(
                  id: mainHomeController.updateTopKey,
                  builder: (context) {
                    if (mainHomeController.topList.isNotEmpty) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: mainHomeController.topList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (index == 2)
                              WebviewBanner(ImagesPaths.ic_explore_dubai,
                                  Endpoints.ExploreDubai),
                            if (index == 3)
                              WebviewBanner(ImagesPaths.ic_things_to_do,
                                  Endpoints.ThingsToDo),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                  mainHomeController.topList[index].heading!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: SizedBox(
                                height: 128,
                                child: ListView.builder(
                                  clipBehavior: Clip.none,
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: mainHomeController
                                          .topList[index].res!.isNotEmpty
                                      ? mainHomeController
                                          .topList[index].res?.length
                                      : 0,
                                  itemBuilder: (BuildContext context,
                                          int idx) =>
                                      ListingCard(
                                          data:
                                              mainHomeController.topList[index],
                                          index: idx),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
