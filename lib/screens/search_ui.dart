import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/app_colors.dart';
import 'package:dubai_local/utils/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../Constants.dart';
import '../models/SearchModel.dart';
import '../models/all_categories_response_model.dart';
import '../models/top_home_response_model.dart';
import '../services/networking_services/api_call.dart';
import '../services/networking_services/endpoints.dart';
import '../utils/localisations/custom_widgets.dart';
import '../utils/localisations/images_paths.dart';

class SearchUi extends StatefulWidget {
  final Function(int index)? changeIndex;
  final Function(Map args)? setArgs;
  final Function() onBack;
  final Function() returnToHome;
  final List<TopHomeData> topList;
  final Map args;

  const SearchUi(
      {Key? key,
      required this.changeIndex,
      required this.setArgs,
      required this.onBack,
      required this.topList,
      required this.returnToHome,
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
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

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
                            horizontal: 4, vertical: 3.8),
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
                      rippleColor: const Color.fromARGB(80, 255, 255, 255),
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
                      child: const SizedBox.shrink())),
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
                    rippleColor: const Color.fromARGB(80, 255, 255, 255),
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
                    child: const SizedBox.shrink())),
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
              height: 130,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );

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
                                fontSize: 10,
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
                    rippleColor: const Color.fromARGB(80, 255, 255, 255),
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
                    child: const SizedBox.shrink())),
          )
        ],
      );
    }

    void sendEnquiry() {
      CallAPI().sendEnquiry(body: {
        "name": nameController.text,
        "email": emailController.text,
        // "url": _businessDetail?.businessData?.url ?? "",
        "query": messageController.text,
        "mobile": phoneController.text,
      }).then((value) {
        if (value == null) {
          ToastContext().init(context);
          Toast.show("Something went wrong");
        } else {
          nameController.clear();
          emailController.clear();
          phoneController.clear();
          messageController.clear();
          ToastContext().init(context);
          Toast.show(value["message"] ?? "Enquiry sent successfully",
              duration: 5);
        }
      }).catchError((onError) {});
    }

    bool validateAndSave() {
      final FormState form = _formKey.currentState!;
      if (form.validate()) {
        return true;
      } else {
        return false;
      }
    }

    openDialog() {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: SizedBox(
                width: width,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: const Text("Send Enquiry"),
                                ),
                                Positioned(
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    },
                                    child: const Icon(Icons.close),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Enter Name",
                          errorMaxLines: 2,
                        ),
                        validator: (value) => value!.isEmpty ||
                                !RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)
                            ? 'Please enter a valid name'
                            : null,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 4),
                              child: TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  labelText: "Enter Email",
                                  errorMaxLines: 2,
                                ),
                                validator: (value) => value!.isEmpty ||
                                        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                            .hasMatch(value)
                                    ? 'Please enter valid email'
                                    : null,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 4),
                              child: TextFormField(
                                controller: phoneController,
                                decoration: const InputDecoration(
                                  labelText: "Enter Phone",
                                  errorMaxLines: 2,
                                ),
                                validator: (value) =>
                                    value!.length > 15 || value.length < 9
                                        ? 'Please enter valid phone no.'
                                        : null,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          labelText: "Enter Message",
                          errorMaxLines: 2,
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Message cannot be blank' : null,
                        maxLines: 3,
                        style: const TextStyle(fontSize: 14),
                      ),
                      GestureDetector(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(Constants.themeColorRed),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          if (validateAndSave()) {
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                            sendEnquiry();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Column(
        children: [
          HeaderWidget(
            isBackEnabled: false,
            changeIndex: widget.changeIndex,
            returnToHome: widget.returnToHome,
            onBack: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
            ),
            child: Text(
              "Search Results",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
            ),
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SearchWidget(
                        isLight: false,
                        changeIndex: null,
                        setArgs: null,
                        isListEnabled: false,
                        updateListing: (searchList) {
                          setState(() {
                            this.searchList = searchList;
                          });
                        }),
                  ),
                  searchList.isEmpty
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
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
                                  topList.isNotEmpty
                                      ? ListView.builder(
                                          // padding: EdgeInsets.only(top: 16),
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: topList.length,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              Container(
                                            color: topList[index]
                                                        .source
                                                        ?.toLowerCase() ==
                                                    "recent_businesses"
                                                ? const Color(0xffEEF1F8)
                                                : Colors.white,
                                            padding: EdgeInsets.symmetric(
                                                vertical: topList[index]
                                                            .source
                                                            ?.toLowerCase() ==
                                                        "recent_businesses"
                                                    ? 8
                                                    : 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (index == 2)
                                                  WebviewBanner(
                                                      ImagesPaths
                                                          .ic_explore_dubai,
                                                      Endpoints.ExploreDubai),
                                                if (index == 4)
                                                  WebviewBanner(
                                                      ImagesPaths
                                                          .ic_things_to_do,
                                                      Endpoints.ThingsToDo),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                        topList[index]
                                                                .heading ??
                                                            "",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                  child: SizedBox(
                                                    height: widget
                                                                    .topList[
                                                                        index]
                                                                    .source
                                                                    ?.toLowerCase() ==
                                                                "blog" &&
                                                            widget
                                                                    .topList[
                                                                        index]
                                                                    .res!
                                                                    .length >
                                                                2
                                                        ? (128 * 2) + 32
                                                        : 128,
                                                    child: widget.topList[index]
                                                                .source
                                                                ?.toLowerCase() ==
                                                            "blog"
                                                        ? Column(
                                                            children: [
                                                              GridView.builder(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top: 8),
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                itemCount: widget
                                                                        .topList[
                                                                            index]
                                                                        .res!
                                                                        .isNotEmpty
                                                                    ? widget.topList[index].res!.length >
                                                                            4
                                                                        ? 4
                                                                        : widget
                                                                            .topList[index]
                                                                            .res
                                                                            ?.length
                                                                    : 0,
                                                                gridDelegate:
                                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                                  crossAxisCount:
                                                                      2,
                                                                  childAspectRatio:
                                                                      2 / 1.3,
                                                                ),
                                                                itemBuilder: (BuildContext
                                                                            context,
                                                                        int
                                                                            idx) =>
                                                                    ListingCardBlog(
                                                                        data: widget.topList[
                                                                            index],
                                                                        index:
                                                                            idx),
                                                              ),
                                                              if (widget
                                                                      .topList[
                                                                          index]
                                                                      .res!
                                                                      .length >
                                                                  2) ...[
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    widget
                                                                        .setArgs!({
                                                                      "url": Endpoints
                                                                          .Blog
                                                                    });
                                                                    widget.changeIndex!(
                                                                        7);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        top: 8),
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            8,
                                                                        vertical:
                                                                            4),
                                                                    decoration: const BoxDecoration(
                                                                        color: Color(
                                                                            0xff318805),
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(2))),
                                                                    child:
                                                                        const Text(
                                                                      "Check All Events",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              10),
                                                                    ),
                                                                  ),
                                                                )
                                                              ]
                                                            ],
                                                          )
                                                        : ListView.builder(
                                                            clipBehavior:
                                                                Clip.none,
                                                            physics:
                                                                const ClampingScrollPhysics(),
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount: widget
                                                                    .topList[
                                                                        index]
                                                                    .res!
                                                                    .isNotEmpty
                                                                ? widget
                                                                    .topList[
                                                                        index]
                                                                    .res
                                                                    ?.length
                                                                : 0,
                                                            itemBuilder: (BuildContext
                                                                        context,
                                                                    int idx) =>
                                                                ListingCard(
                                                                    data: widget
                                                                            .topList[
                                                                        index],
                                                                    index: idx),
                                                          ),
                                                  ),
                                                ),
                                                if (topList[index]
                                                        .source
                                                        ?.toLowerCase() ==
                                                    "recent_businesses") ...[
                                                  Transform.translate(
                                                    offset: Offset(0, -8),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        openDialog();
                                                      },
                                                      child: Center(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 4),
                                                          decoration: const BoxDecoration(
                                                              color: Color(
                                                                  0xff318805),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          2))),
                                                          child: const Text(
                                                            "List Your Business Now",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ]
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
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
                                          "${double.tryParse(searchItems.average_rating!) ?? 0.toStringAsFixed(1)}",
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
