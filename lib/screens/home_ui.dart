import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/models/all_categories_response_model.dart';
import 'package:dubai_local/services/networking_services/endpoints.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import 'package:dubai_local/utils/search_widget.dart';
import 'package:flutter/material.dart';

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

    Widget ListingCardBlog({required TopHomeData data, required int index}) {
      return Stack(
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
              width: (width - 32 - 8) / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.res![index].image != null ||
                      data.res![index].icon != null) ...[
                    Expanded(
                      child: Image.network(
                        width: (width - 32 - 8) / 2,
                        data.source?.toLowerCase() == "blog"
                            ? data.res![index].image!
                            : data.res![index].icon!,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
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
                            data.source?.toLowerCase() == "blog"
                                ? data.res![index].title!
                                : data.res![index].name!,
                            style: const TextStyle(
                                fontSize: 8,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                            maxLines: 1,
                            textAlign: TextAlign.center,
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
                      if (data.source?.toLowerCase() == "business") {
                        if (data.res![index].slug != null) {
                          openSubCategoryBusiness(
                              context, "", data.res![index].slug!);
                        }
                      } else if (data.source?.toLowerCase() == "blog") {
                        if (data.res![index].url != null) {
                          widget.changeIndex!(7);
                          widget.setArgs!({"url": data.res![index].url!});
                        }
                        // Navigator.pushNamed(context, AppRoutes.webview,
                        //     arguments: {"url": data.res![index].link!});
                      }
                    },
                    child: SizedBox.shrink())),
          )
        ],
      );
    }

    Widget ListingCard({required TopHomeData data, required int index}) {
      if (data.source?.toLowerCase() == "recent_businesses") {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: (width - 32 - 8) / 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (data.res![index].full_banner != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          width: (width - 32 - 8) / 5,
                          height: (width - 32 - 8) / 5,
                          data.res![index].full_banner!,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              data.res![index].name!,
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                              maxLines: 2,
                              textAlign: TextAlign.center,
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
                        if (data.source?.toLowerCase() == "business") {
                          if (data.res![index].slug != null) {
                            openSubCategoryBusiness(
                                context, "", data.res![index].slug!);
                          }
                        } else if (data.source?.toLowerCase() ==
                            "recent_businesses") {
                          if (data.res![index].slug != null) {
                            widget.setArgs!({"slug": data.res![index].slug});
                            widget.changeIndex!(8);
                          }
                        } else if (data.source?.toLowerCase() == "blog") {
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
      }
      return Stack(
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
              height: ((width - 32 - 8) / 3) * .90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.res![index].image != null ||
                      data.res![index].icon != null) ...[
                    Expanded(
                      child: Image.network(
                        data.source?.toLowerCase() == "blog"
                            ? data.res![index].image!
                            : data.res![index].icon!,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
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
                            data.source?.toLowerCase() == "blog"
                                ? data.res![index].title!
                                : data.res![index].name!,
                            style: const TextStyle(
                                fontSize: 8,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
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
                      if (data.source?.toLowerCase() == "business") {
                        if (data.res![index].slug != null) {
                          openSubCategoryBusiness(
                              context, "", data.res![index].slug!);
                        }
                      } else if (data.source?.toLowerCase() == "blog") {
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
    }

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
              height: 72,
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
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(text: "Welcome to "),
                    TextSpan(
                        text: "Dubai Local",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
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
                  SearchWidget(
                    isLight: true,
                    changeIndex: widget.changeIndex,
                    setArgs: widget.setArgs,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: widget.categoryList.isNotEmpty
                        ? GridView.builder(
                            padding: const EdgeInsets.only(top: 8),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: 10,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5,
                                    childAspectRatio: 5 / 4.5,
                                    mainAxisSpacing: 20 / 2,
                                    crossAxisSpacing: 10),
                            itemBuilder: (BuildContext context, int index) {
                              return InkButton(
                                rippleColor:
                                    const Color(Constants.themeColorRed),
                                backGroundColor: const Color(0xffffffff),
                                borderRadius: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xffD5DEF2),
                                          style: BorderStyle.solid,
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      index == 9
                                          ? Expanded(
                                              child: Image.asset(
                                                ImagesPaths.ic_more_svg,
                                                width: 25,
                                              ),
                                            )
                                          : Expanded(
                                              child: SizedBox(
                                                  width: 25,
                                                  child: Image.network(widget
                                                      .categoryList[index]
                                                      .fullIcon)),
                                            ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Color(0xffD5DEF2)),
                                        child: Text(
                                          (() {
                                            if (index == 9) {
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
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  if (index == 9) {
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
                  widget.topList.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.topList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                            color:
                                widget.topList[index].source?.toLowerCase() ==
                                        "recent_businesses"
                                    ? const Color(0xffEEF1F8)
                                    : Colors.white,
                            padding: EdgeInsets.symmetric(
                                vertical: widget.topList[index].source
                                            ?.toLowerCase() ==
                                        "recent_businesses"
                                    ? 8
                                    : 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (index == 2)
                                  WebviewBanner(ImagesPaths.ic_explore_dubai,
                                      Endpoints.ExploreDubai),
                                if (index == 4)
                                  WebviewBanner(ImagesPaths.ic_things_to_do,
                                      Endpoints.ThingsToDo),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                        widget.topList[index].heading ?? "",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: SizedBox(
                                    height: widget.topList[index].source
                                                    ?.toLowerCase() ==
                                                "blog" &&
                                            widget.topList[index].res!.length >
                                                2
                                        ? (128 * 2) + 32
                                        : 128,
                                    child: widget.topList[index].source
                                                ?.toLowerCase() ==
                                            "blog"
                                        ? Column(
                                            children: [
                                              GridView.builder(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                itemCount: widget.topList[index]
                                                        .res!.isNotEmpty
                                                    ? widget.topList[index].res!
                                                                .length >
                                                            4
                                                        ? 4
                                                        : widget.topList[index]
                                                            .res?.length
                                                    : 0,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 2 / 1.3,
                                                ),
                                                itemBuilder:
                                                    (BuildContext context,
                                                            int idx) =>
                                                        ListingCardBlog(
                                                            data: widget
                                                                .topList[idx],
                                                            index: idx),
                                              ),
                                              if (widget.topList[index].res!
                                                      .length >
                                                  2) ...[
                                                GestureDetector(
                                                  onTap: () {
                                                    widget.setArgs!({
                                                      "url": Endpoints.Blog
                                                    });
                                                    widget.changeIndex!(7);
                                                  },
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.only(top: 8),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Color(
                                                                0xff318805),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            2))),
                                                    child: const Text(
                                                      "Check All Events",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                )
                                              ]
                                            ],
                                          )
                                        : ListView.builder(
                                            clipBehavior: Clip.none,
                                            physics:
                                                const ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: widget.topList[index]
                                                    .res!.isNotEmpty
                                                ? widget
                                                    .topList[index].res?.length
                                                : 0,
                                            itemBuilder: (BuildContext context,
                                                    int idx) =>
                                                ListingCard(
                                                    data: widget.topList[index],
                                                    index: idx),
                                          ),
                                  ),
                                ),
                              ],
                            ),
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
