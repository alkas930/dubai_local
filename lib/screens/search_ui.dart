import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/app_colors.dart';
import 'package:dubai_local/utils/search_widget.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';
import '../models/SearchModel.dart';
import '../models/all_categories_response_model.dart';
import '../models/top_home_response_model.dart';
import '../services/networking_services/endpoints.dart';
import '../utils/localisations/custom_widgets.dart';
import '../utils/localisations/images_paths.dart';

class SearchUi extends StatefulWidget {
  final Function(int index)? changeIndex;
  final Function(Map args)? setArgs;
  final Function() onBack;
  final Map args;

  const SearchUi(
      {Key? key,
      required this.changeIndex,
      required this.setArgs,
      required this.onBack,
      required this.args})
      : super(key: key);

  @override
  State<SearchUi> createState() => _SearchUiState();
}

class _SearchUiState extends State<SearchUi> {
  List<SearchModelData> searchList = [];
  List<AllCategoriesData> categoryList = [];
  List<TopHomeData> topList = [];

  void openBusinessDetails(BuildContext context, String businessSlug) {
    // Navigator.pushNamed(context, AppRoutes.mainBusiness,
    //     arguments: {"slug": businessSlug});
    widget.setArgs!({"slug": businessSlug});
    widget.changeIndex!(8);
  }

  @override
  Widget build(BuildContext context) {
    final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    if (args["categoryList"] != null && args["categoryList"]?.isNotEmpty) {
      categoryList = List<AllCategoriesData>.from(args["categoryList"]);
    }
    if (args["topList"] != null && args["topList"]?.isNotEmpty) {
      topList = List<TopHomeData>.from(args["topList"]);
    }
    Future<bool> _onWillPop() async {
      // Navigator.pop(context);
      widget.onBack();
      return false;
    }

    void openSubCategoryBusiness(
        BuildContext context, String subCategory, String slug) {
      // Navigator.pushNamed(context, AppRoutes.detail, arguments: {
      //   "catName": args["catName"],
      //   "subCat": subCategory,
      //   "slug": slug
      // });
      widget.setArgs!({"catName": "", "subCat": "", "slug": slug});
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

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Column(
        children: [
          HeaderWidget(
            isBackEnabled: false,
            changeIndex: widget.changeIndex,
            onBack: () {},
          ),
          Text(
            "Search Results",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Expanded(
            child: Container(
              width: width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchWidget(
                      isLight: false,
                      changeIndex: null,
                      setArgs: null,
                      isListEnabled: false,
                      updateListing: (searchList) {
                        setState(() {
                          this.searchList = searchList;
                        });
                      }),
                  searchList.isEmpty
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                topList.isNotEmpty
                                    ? ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: topList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (index == 2)
                                              WebviewBanner(
                                                  ImagesPaths.ic_explore_dubai,
                                                  Endpoints.ExploreDubai),
                                            if (index == 3)
                                              WebviewBanner(
                                                  ImagesPaths.ic_things_to_do,
                                                  Endpoints.ThingsToDo),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Text(
                                                  topList[index].heading!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.start),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 24),
                                              child: SizedBox(
                                                height: 128,
                                                child: ListView.builder(
                                                  clipBehavior: Clip.none,
                                                  physics:
                                                      const ClampingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: topList[index]
                                                          .res!
                                                          .isNotEmpty
                                                      ? topList[index]
                                                          .res
                                                          ?.length
                                                      : 0,
                                                  itemBuilder: (BuildContext
                                                              context,
                                                          int idx) =>
                                                      ListingCard(
                                                          data: topList[index],
                                                          index: idx),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: searchList.length,
                              itemBuilder: (BuildContext ctx, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    openBusinessDetails(
                                        context, searchList[index].slug!);
                                  },
                                  child: items(searchItems: searchList[index]),
                                );
                              }),
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget items({required SearchModelData searchItems}) {
    const double cardHeight = 96;
    const double imageRatio = 0.8; // 0 - min, 1 - max
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 8,
        shadowColor: Colors.black,
        color: const Color(0xffF7F7F7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: cardHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: cardHeight * imageRatio,
                      width: cardHeight * imageRatio,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          "${Endpoints.BASE_URL}assets/logo/${searchItems.banner!}",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  searchItems.name!,
                                  style: const TextStyle(
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                child: Row(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                            color: const Color(0xff87B43D),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Text(
                                          "${double.tryParse(searchItems.avgRating!) ?? 0.toStringAsFixed(1)}",
                                          style: const TextStyle(
                                              fontSize: 6,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Image.asset(
                                  ImagesPaths.ic_location,
                                  color: const Color(0xff818181),
                                  width: 12,
                                  height: 12,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    searchItems.address!,
                                    style: const TextStyle(
                                      color: Color(0xff818181),
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                ImagesPaths.ic_phone,
                                color: const Color(0xff818181),
                                width: 12,
                                height: 12,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  searchItems.phone!,
                                  style: const TextStyle(
                                    color: Color(0xff818181),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
