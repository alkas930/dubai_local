import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/models/all_categories_response_model.dart';
import 'package:dubai_local/services/networking_services/endpoints.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import 'package:dubai_local/utils/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';

import '../models/top_home_response_model.dart';
import '../utils/localisations/app_colors.dart';
import '../utils/localisations/images_paths.dart';

class HomeUI extends StatefulWidget {
  final Function(int index)? changeIndex;
  final Function(Map args)? setArgs;
  final List<AllCategoriesData> categoryList;
  final List<TopHomeData> topList;
  final Function() onBack;
  final Map args;

  const HomeUI(
      {Key? key,
      this.changeIndex,
      required this.categoryList,
      required this.setArgs,
      required this.onBack,
      required this.topList,
      required this.args})
      : super(key: key);

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    void openSubCategory(BuildContext context, String catName, String slug) {
      // Navigator.pushNamed(context, AppRoutes.subCategories,
      //     arguments: {"catName": catName, "slug": slug});
      widget.setArgs!({"catName": catName, "slug": slug});
      widget.changeIndex!(5);
    }

    void openSubCategoryBusiness(
        BuildContext context, String subCategory, String slug) {
      // Navigator.pushNamed(context, AppRoutes.detail, arguments: {
      //   "catName": args["catName"],
      //   "subCat": subCategory,
      //   "slug": slug
      // });
      widget.setArgs!({
        "catName": widget.args["catName"],
        "subCat": subCategory,
        "slug": slug
      });
      widget.changeIndex!(6);
    }

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
                width: (width - 32 - 8) / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data.res![index].icon != null) ...[
                      Expanded(
                        child: Image.network(
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
                        ),
                      )
                    ],
                    Center(
                      child: Container(
                        // decoration: const BoxDecoration(color: Colors.transparent),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.res![index].name!,
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(Constants.themeColorRed),
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // Row(
                            //   children: [
                            //     Image.asset(
                            //       ImagesPaths.ic_location,
                            //       scale: 12,
                            //       color: const Color(0xff444444),
                            //     ),
                            //     Expanded(
                            //       child: Text(
                            //         data.res![index].name!,
                            //         style: const TextStyle(
                            //             fontSize: 10,
                            //             color: Color(0xff444444)),
                            //         maxLines: 1,
                            //         overflow: TextOverflow.ellipsis,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
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
                            openSubCategoryBusiness(
                                context, "", data.res![index].slug!);
                          }
                        } else if (data.source == "blog") {
                          if (data.res![index].link != null) {
                            widget.changeIndex!(7);
                            widget.setArgs!({"url": data.res![index].link!});
                          }
                          // Navigator.pushNamed(context, AppRoutes.webview,
                          //     arguments: {"url": data.res![index].link!});
                        }
                      },
                      child: SizedBox.shrink())),
            )
          ],
        );

    Widget WebviewBanner(String image, String url) => GestureDetector(
          onTap: () {
            widget.setArgs!({"url": url});
            widget.changeIndex!(7);

            // Navigator.pushNamed(context, AppRoutes.webview,
            //     arguments: {"url": url});
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: SizedBox(
              width: width,
              height: 130,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
    Future<bool> _onWillPop() async {
      // Navigator.pop(context);
      widget.onBack();
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderWidget(
              isBackEnabled: false,
              changeIndex: widget.changeIndex,
              onBack: () {},
            ),
            const Padding(
              padding: EdgeInsets.only(top: 32),
              child: Text(
                "Choose A Category",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              width: width,
              constraints: BoxConstraints(minHeight: height),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: widget.categoryList.isNotEmpty
                        ? GridView.builder(
                            padding: EdgeInsets.only(top: 8),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                                      widget.categoryList[index]
                                                          .fullIcon)),
                                              onLoading: (ctx) {
                                                return SizedBox(
                                                    child:
                                                        CircularProgressIndicator(
                                                  color: AppColors.accentRipple,
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
                                          return widget
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
                                  if (index == 7) {
                                    widget.changeIndex!(3);
                                  } else {
                                    openSubCategory(
                                      context,
                                      widget.categoryList[index].name,
                                      widget.categoryList[index].slug,
                                    );
                                  }
                                },
                              );
                            })
                        : const SizedBox.shrink(),
                  ),
                  SearchWidget(
                    isLight: true,
                    changeIndex: widget.changeIndex,
                    setArgs: widget.setArgs,
                  ),
                  // .marginOnly(top: 16, bottom: 16),

                  widget.topList.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.topList.length,
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
                                child: Text(widget.topList[index].heading!,
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
                                    itemCount:
                                        widget.topList[index].res!.isNotEmpty
                                            ? widget.topList[index].res?.length
                                            : 0,
                                    itemBuilder:
                                        (BuildContext context, int idx) =>
                                            ListingCard(
                                                data: widget.topList[index],
                                                index: idx),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
