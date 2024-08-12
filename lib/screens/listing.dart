import 'dart:developer';

import 'package:dubai_local/models/SubCategoryBusinessResponseModel.dart';
import 'package:dubai_local/models/business_details_response_model.dart';
import 'package:dubai_local/services/networking_services/api_call.dart';
import 'package:dubai_local/services/networking_services/endpoints.dart';
import 'package:dubai_local/theme_controller.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import 'package:dubai_local/utils/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toast/toast.dart';
// import 'package:velocity_x/velocity_x.dart';

import '../Constants.dart';
import '../utils/localisations/app_colors.dart';
import '../utils/localisations/images_paths.dart';

class DetailUi extends StatefulWidget {
  final Function(int index)? changeIndex;
  final Function(Map args)? setArgs;
  final Function() onBack;
  final Function() returnToHome;
  final Map args;

  const DetailUi(
      {Key? key,
      required this.changeIndex,
      required this.setArgs,
      required this.onBack,
      required this.returnToHome,
      required this.args})
      : super(key: key);

  @override
  State<DetailUi> createState() => _DetailUiState();
}

class _DetailUiState extends State<DetailUi> {
  List<SubcatBusinessData> detailList = [];
  String category = "";
  String subCategory = "";
  final _formKey = GlobalKey<FormState>();
  BusinessDetailResponseModel? _businessDetail;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  void getData(String slug) {
    CallAPI().getSubCategoriesBusiness(slug: slug).then((value) {
      print("DATA: ${value}");
      if (value.subcatBusinessData!.isNotEmpty) {
        setState(() {
          detailList = value.subcatBusinessData!;
          category = value.catName?[0].name! ?? "";
          subCategory = value.catName?[0].subcatName! ?? "";
        });
      }
    }).onError((error, stackTrace) {
      print("$error $stackTrace");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final Map args =
      //     (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
      getData(widget?.args?["slug"] ?? "");
    });
  }

  bool validateAndSave() {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void sendEnquiry() {
    CallAPI().sendEnquiry(body: {
      "name": nameController.text,
      "email": emailController.text,
      "url": _businessDetail?.businessData?.url ?? "",
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

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    // final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    Future<bool> _onWillPop() async {
      // Navigator.pop(context);
      widget.onBack();
      return false;
    }

    void openBusinessDetails(BuildContext context, String businessSlug) {
      // Navigator.pushNamed(context, AppRoutes.mainBusiness,
      //     arguments: {"slug": businessSlug});
      widget.setArgs!({"slug": businessSlug});
      widget.changeIndex!(8);
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Column(
        children: [
          Column(
            children: [
              HeaderWidget(
                isBackEnabled: true,
                changeIndex: widget.changeIndex,
                onBack: widget.onBack,
                returnToHome: widget.returnToHome,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 20),
                    child: Text(
                      category ?? "",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 10),
                  //   child: Text(
                  //     "-${widget.args["subCat"] ?? subCategory ?? ""}-",
                  //     style: TextStyle(color: Colors.white, fontSize: 12),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                detailList.isEmpty
                    ? Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(Constants.themeColorRed),
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeController.isDark.value
                          ? const Color.fromARGB(255, 36, 36, 36)
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        SearchWidget(
                          isLight: true,
                          changeIndex: widget.changeIndex,
                          setArgs: widget.setArgs,
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: detailList.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return GestureDetector(
                                onTap: () {
                                  openBusinessDetails(
                                      context, detailList[index].slug!);
                                },
                                child: items(searchItems: detailList[index]),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget items({required SubcatBusinessData searchItems}) {
    ThemeController themeController = Get.put(ThemeController());
    void openBusinessDetails(BuildContext context, String businessSlug) {
      // Navigator.pushNamed(context, AppRoutes.mainBusiness,
      //     arguments: {"slug": businessSlug});
      widget.setArgs!({"slug": businessSlug});
      widget.changeIndex!(8);
    }

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
                          searchItems.full_banner!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
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
                                      // VxRating(
                                      //   onRatingUpdate: (v) {},
                                      //   size: 10,
                                      //   normalColor: AppColors.grey,
                                      //   selectionColor: AppColors.yellow,
                                      //   maxRating: 5,
                                      //   count: 5,
                                      //   value: searchItems.average_rating !=
                                      //           null
                                      //       ? double.parse(double.parse(
                                      //               searchItems.average_rating!)
                                      //           .toStringAsFixed(2))
                                      //       : 0,
                                      //   isSelectable: false,
                                      // ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(left: 8),
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
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: SizedBox(
                                        // width: width,
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8),
                                                          child: const Text(
                                                              "Send Enquiry"),
                                                        ),
                                                        Positioned(
                                                          right: 0,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context,
                                                                      rootNavigator:
                                                                          true)
                                                                  .pop(
                                                                      'dialog');
                                                            },
                                                            child: const Icon(
                                                                Icons.close),
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
                                                      _businessDetail
                                                              ?.businessData
                                                              ?.name ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TextFormField(
                                                controller: nameController,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "Enter Name",
                                                  errorMaxLines: 2,
                                                ),
                                                validator: (value) => value!
                                                            .isEmpty ||
                                                        !RegExp(r"^[a-zA-Z\s]+$")
                                                            .hasMatch(value)
                                                    ? 'Please enter a valid name'
                                                    : null,
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 4),
                                                      child: TextFormField(
                                                        controller:
                                                            emailController,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              "Enter Email",
                                                          errorMaxLines: 2,
                                                        ),
                                                        validator: (value) => value!
                                                                    .isEmpty ||
                                                                !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                                    .hasMatch(
                                                                        value)
                                                            ? 'Please enter valid email'
                                                            : null,
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 4),
                                                      child: TextFormField(
                                                        controller:
                                                            phoneController,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              "Enter Phone",
                                                          errorMaxLines: 2,
                                                        ),
                                                        validator: (value) => value!
                                                                        .length >
                                                                    15 ||
                                                                value.length < 9
                                                            ? 'Please enter valid phone no.'
                                                            : null,
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TextFormField(
                                                controller: messageController,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "Enter Message",
                                                  errorMaxLines: 2,
                                                ),
                                                validator: (value) => value!
                                                        .isEmpty
                                                    ? 'Message cannot be blank'
                                                    : null,
                                                maxLines: 3,
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                              GestureDetector(
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color(Constants
                                                              .themeColorRed),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          16))),
                                                  margin: const EdgeInsets.only(
                                                      top: 16),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16,
                                                      vertical: 4),
                                                  child: const Text(
                                                    "Submit",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                onTap: () {
                                                  if (validateAndSave()) {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
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
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.greenTheme),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Row(
                                        children: [
                                          // Image.asset(
                                          //   ImagesPaths.ic_send_enquiry,
                                          //   width: 12,
                                          //   color: Colors.white,
                                          // ),
                                          const Text(
                                            "Enquiry Now",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      openBusinessDetails(
                                          context, detailList[0].slug!);
                                    },
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xff9B6A12)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        child: Row(
                                          children: [
                                            // Image.asset(
                                            //   ImagesPaths.ic_send_enquiry,
                                            //   width: 12,
                                            //   color: Colors.white,
                                            // ),
                                            const Text(
                                              " View Details",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
