import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/app_colors.dart';
import 'package:dubai_local/utils/search_widget.dart';
import 'package:flutter/material.dart';
import '../models/SearchModel.dart';
import '../services/networking_services/endpoints.dart';
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

  void openBusinessDetails(BuildContext context, String businessSlug) {
    // Navigator.pushNamed(context, AppRoutes.mainBusiness,
    //     arguments: {"slug": businessSlug});
    widget.setArgs!({"slug": businessSlug});
    widget.changeIndex!(8);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    Future<bool> _onWillPop() async {
      // Navigator.pop(context);
      widget.onBack();
      return false;
    }

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
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
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
