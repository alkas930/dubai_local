import 'dart:async';

import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/models/SearchModel.dart';
import 'package:dubai_local/services/networking_services/api_call.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final bool isLight;
  final double width;
  final bool isListEnabled;
  final Function(int index)? changeIndex;
  final Function(Map args)? setArgs;
  final Function(List<SearchModelData> searchList)? updateListing;

  const SearchWidget(
      {Key? key,
      required this.isLight,
      this.width = 0.8,
      required this.changeIndex,
      required this.setArgs,
      this.updateListing,
      this.isListEnabled = true})
      : super(key: key);

  @override
  _SearchWidget createState() => _SearchWidget();
}

class _SearchWidget extends State<SearchWidget> {
  List<SearchModelData> searchList = [];
  Timer? _debounce;

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.trim().length >= 3 || query.trim().isNotEmpty) {
        if (widget.isListEnabled) {
          searchKeyword(query);
        } else {
          searchData(query);
        }
      } else {
        if (widget.isListEnabled == true) {
          setState(() {
            searchList = [];
          });
        } else {
          widget.updateListing!([]);
        }
      }
    });
  }

  void openBusinessDetails(BuildContext context, String businessSlug) {
    // Navigator.pushNamed(context, AppRoutes.mainBusiness,
    //     arguments: {"slug": businessSlug});
    widget.setArgs!({"slug": businessSlug, "isSearch": true});
    widget.changeIndex!(8);
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

  void searchData(String query) {
    CallAPI().search(body: {"query": query}).then((value) {
      if (widget.isListEnabled == true) {
        if (value.error == null) {
          setState(() {
            searchList = value.data ?? [];
          });
        } else {
          setState(() {
            searchList = [];
          });
        }
      } else {
        widget.updateListing!(value.data ?? []);
      }
    }).catchError((onError) {
      setState(() {
        searchList = [];
      });
    });
  }

  void searchKeyword(String query) {
    CallAPI().searchKeywords(keyword: query).then((value) {
      if (widget.isListEnabled == true) {
        if (value.error == null) {
          setState(() {
            searchList = value.data ?? [];
          });
        } else {
          setState(() {
            searchList = [];
          });
        }
      } else {
        widget.updateListing!(value.data ?? []);
      }
    }).catchError((onError) {
      setState(() {
        searchList = [];
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
        clipBehavior: Clip.none,
        margin: const EdgeInsets.only(top: 16),
        width: width * widget.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            )),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 0.5, offset: Offset(0, 8), spreadRadius: -8)
                  ]),
              width: width * widget.width,
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Color(0xff626262),
                  ),
                  hintText: "Try 'Asian Cuisine' or 'Mobile shop'",
                  hintStyle:
                      const TextStyle(fontSize: 12, color: Color(0xff626262)),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(Constants.themeColorRed)),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                style: const TextStyle(fontSize: 12),
                onChanged: (query) {
                  _onSearchChanged(query);
                },
              ),
            ),
            searchList.isNotEmpty
                ? Container(
                    constraints: BoxConstraints(maxHeight: height * 0.50),
                    child: ListView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 8, bottom: 64),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: searchList.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (searchList[index].keyword_source == "2") {
                              openBusinessDetails(
                                  context, searchList[index].keyword!);
                            } else {
                              openSubCategoryBusiness(
                                  context, "", searchList[index].subcat_slug!);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  searchList[index].keyword ?? "",
                                  style: const TextStyle(fontSize: 10),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Divider()
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ));
  }
}
