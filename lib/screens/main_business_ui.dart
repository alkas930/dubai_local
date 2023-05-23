import 'dart:convert';
import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/models/business_details_response_model.dart';
import 'package:dubai_local/services/networking_services/api_call.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/app_colors.dart';
import 'package:dubai_local/utils/localisations/images_paths.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

class MainBusinessUI extends StatefulWidget {
  final Function(int index)? changeIndex;
  final Function(Map args)? setArgs;
  final Function() onBack;
  final Map args;

  MainBusinessUI(
      {Key? key,
      required this.changeIndex,
      required this.setArgs,
      required this.onBack,
      required this.args})
      : super(key: key);

  @override
  State<MainBusinessUI> createState() => _MainBusinessUIState();
}

class _MainBusinessUIState extends State<MainBusinessUI> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  BusinessDetailResponseModel? _businessDetail;
  bool isVisible = false;

  void callAPI(String businessSlug, bool isSearch) {
    CallAPI()
        .getBusinessDetail(businessSlug: businessSlug, isSearch: isSearch)
        .then((value) {
      setState(() {
        _businessDetail = value;
      });
    });
  }

  void sendEnquiry() {
    CallAPI().sendEnquiry(body: {
      "name": nameController.text,
      "email": emailController.text,
      "url": _businessDetail?.businessData?.url ?? "",
      "query": messageController.text,
      "mobile": "+971${phoneController.text}",
    }).then((value) {
      if (value == null) {
        ToastContext().init(context);
        Toast.show("Something went wrong");
      } else {
        nameController.clear();
        emailController.clear();
        phoneController.clear();
        messageController.clear();
        Navigator.of(context, rootNavigator: true).pop('dialog');
        ToastContext().init(context);
        Toast.show(value["message"] ?? "Enquiry sent successfully");
      }
    }).catchError((onError) {});
  }

  void claimBusiness() {
    CallAPI().claimBusiness(body: {
      "name": nameController.text,
      "email": emailController.text,
      "phone_no": "+971${phoneController.text}",
      "busi_name": _businessDetail?.businessData?.name ?? "",
      "busi_id": _businessDetail?.businessData?.id ?? "",
      "busi_url": _businessDetail?.businessData?.url ?? "",
      "source_from": "1",
    }).then((value) {
      if (value == null) {
        ToastContext().init(context);
        Toast.show("Something went wrong");
      } else {
        nameController.clear();
        emailController.clear();
        phoneController.clear();
        messageController.clear();
        Navigator.of(context, rootNavigator: true).pop('dialog');
        ToastContext().init(context);
        Toast.show(value["message"] ?? "Claim raised successfully");
      }
    }).catchError((onError) {});
  }

  double getRating(double? rating, double avgRating) {
    double avg = 0;
    if (rating == null) {
      avg = avgRating;
    } else {
      avg = (rating + avgRating) / 2;
    }
    return avgRating;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final Map args =
      //     (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
      callAPI(widget.args["slug"] ?? "", widget.args["isSearch"] ?? false);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    // final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;

    Future<bool> _onWillPop() async {
      // Navigator.pop(context);
      widget.onBack();
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            HeaderWidget(
              isBackEnabled: true,
              changeIndex: widget.changeIndex,
              onBack: widget.onBack,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Text(
                    "-${_businessDetail?.businessData?.subCatName ?? ""}-",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    _businessDetail?.businessData?.name ?? "",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.topCenter,
                constraints: BoxConstraints(minHeight: height),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: _businessDetail?.businessData == null
                    ? const Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(Constants.themeColorRed),
                          ),
                        ),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 150,
                            child: Stack(
                              children: [
                                Image.network(
                                  _businessDetail?.businessData?.fullBanner ??
                                      "",
                                  fit: BoxFit.cover,
                                  width: width,
                                  height: 150,
                                ),
                                // Positioned(
                                //   bottom: 15,
                                //   child: Padding(
                                //     padding: const EdgeInsets.symmetric(
                                //         horizontal: 15),
                                //     child: Text(
                                //       _businessDetail?.businessData?.name ?? "",
                                //       style: TextStyle(color: Colors.white),
                                //     ),
                                //   ),
                                // ),
                                Positioned(
                                  bottom: 15,
                                  right: 15,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 8),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 18,
                                            color: Colors.yellow,
                                          ),
                                          const Text(
                                            "4.5",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          customContainer(
                              width: width,
                              icon: ImagesPaths.ic_location,
                              title:
                                  _businessDetail?.businessData?.address ?? "",
                              onTap: () {}),
                          _businessDetail?.businessData?.phone != null &&
                                  _businessDetail?.businessData?.phone != ""
                              ? customContainer(
                                  width: width,
                                  icon: ImagesPaths.ic_phone,
                                  title: _businessDetail?.businessData?.phone ??
                                      "",
                                  onTap: () {
                                    launchUrl(
                                        Uri(
                                            scheme: 'tel',
                                            path: _businessDetail
                                                    ?.businessData?.phone ??
                                                ""),
                                        mode: LaunchMode.externalApplication);
                                  })
                              : SizedBox.shrink(),
                          _businessDetail?.businessData?.url != null &&
                                  _businessDetail?.businessData?.url?.trim() !=
                                      ""
                              ? customContainer(
                                  width: width,
                                  icon: ImagesPaths.ic_web,
                                  isWeb: true,
                                  title:
                                      _businessDetail?.businessData?.url ?? "",
                                  onTap: () {
                                    widget.setArgs!({
                                      "url":
                                          _businessDetail?.businessData?.url ??
                                              ""
                                    });
                                    widget.changeIndex!(7);
                                    // launchUrl(
                                    //   Uri(
                                    //     scheme: 'https',
                                    //     host: _businessDetail
                                    //             ?.businessData?.url ??
                                    //         "",
                                    //   ),
                                    //   mode: LaunchMode.externalApplication,
                                    // );
                                  })
                              : SizedBox.shrink(),
                          workingHoursWidget(
                              width: width,
                              isVisible: isVisible,
                              icon: ImagesPaths.ic_clock,
                              title: "Working Hours",
                              onTap: () {
                                setState(() {
                                  isVisible = isVisible == true ? false : true;
                                });
                              }),
                          isVisible
                              ? getTimings(_businessDetail, width)
                              : const SizedBox.shrink(),
                          Container(
                            color: AppColors.lightGrey,
                            height: 60,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: SingleChildScrollView(
                                            child: Form(
                                              key: _formKey,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets
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
                                                                    Icons
                                                                        .close),
                                                              ),
                                                            ),
                                                          ],
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
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
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
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
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
                                                            validator: (value) =>
                                                                value!.length !=
                                                                        9
                                                                    ? 'Please enter valid phone no.'
                                                                    : null,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        messageController,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText:
                                                          "Enter Message",
                                                      errorMaxLines: 2,
                                                    ),
                                                    validator: (value) => value!
                                                            .isEmpty
                                                        ? 'Message cannot be blank'
                                                        : null,
                                                    maxLines: 5,
                                                  ),
                                                  GestureDetector(
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          color: Color(Constants
                                                              .themeColorRed),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          16))),
                                                      margin:
                                                          const EdgeInsets.only(
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
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      if (validateAndSave()) {
                                                        sendEnquiry();
                                                      }
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.greenTheme),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            ImagesPaths.ic_send_enquiry,
                                            width: 20,
                                            color: Colors.white,
                                          ),
                                          const Text(
                                            " Send Enquiry",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Share.share(
                                        "https://dubailocal.ae/business/${_businessDetail?.businessData?.slug ?? ""}",
                                        subject: _businessDetail
                                                ?.businessData?.name ??
                                            "");
                                  },
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.greenTheme),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            ImagesPaths.ic_send_enquiry,
                                            width: 20,
                                            color: Colors.white,
                                          ),
                                          const Text(
                                            " Send to Friend",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                                width: width - 50,
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  _businessDetail?.businessData?.name ?? "",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                                width: width - 50,
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  _businessDetail?.businessData?.description ??
                                      "",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      wordSpacing: -1),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Container(
                              height: 40,
                              width: 160,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(Constants.themeColorRed),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: SingleChildScrollView(
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                                    vertical:
                                                                        8),
                                                            child: const Text(
                                                                "Claim This Business"),
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
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 4),
                                                        child: TextFormField(
                                                          controller:
                                                              nameController,
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText:
                                                                "Enter Name",
                                                            errorMaxLines: 2,
                                                          ),
                                                          validator: (value) => value!
                                                                      .isEmpty ||
                                                                  !RegExp(r"^[a-zA-Z\s]+$")
                                                                      .hasMatch(
                                                                          value)
                                                              ? 'Please enter a valid name'
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 4),
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
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                TextFormField(
                                                  controller: phoneController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: "Enter Phone",
                                                    errorMaxLines: 2,
                                                  ),
                                                  validator: (value) => value!
                                                              .length !=
                                                          9
                                                      ? 'Please enter valid phone no.'
                                                      : null,
                                                ),
                                                GestureDetector(
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                        color: Color(Constants
                                                            .themeColorRed),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    16))),
                                                    margin:
                                                        const EdgeInsets.only(
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
                                                      claimBusiness();
                                                    }
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 4),
                                    child: FittedBox(
                                      child: Text(
                                        "Own This Business?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Colors.white),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          getGallery(
                              _businessDetail?.businessData?.moreImages ?? ""),
                        ],
                      )),
          ],
        ),
      ),
    );

    return WillPopScope(
      onWillPop: _onWillPop,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: _businessDetail?.businessData == null
            ? SizedBox.shrink()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HeaderWidget(
                    isBackEnabled: true,
                    changeIndex: widget.changeIndex,
                    onBack: widget.onBack,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      _businessDetail?.businessData?.name ?? "",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Container(
                      alignment: Alignment.topCenter,
                      constraints: BoxConstraints(minHeight: height),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 150,
                            child: Stack(
                              children: [
                                Image.network(
                                  _businessDetail?.businessData?.fullBanner ??
                                      "",
                                  fit: BoxFit.cover,
                                  width: width,
                                  height: 150,
                                ),
                                // Positioned(
                                //   bottom: 15,
                                //   child: Padding(
                                //     padding: const EdgeInsets.symmetric(
                                //         horizontal: 15),
                                //     child: Text(
                                //       _businessDetail?.businessData?.name ?? "",
                                //       style: TextStyle(color: Colors.white),
                                //     ),
                                //   ),
                                // ),
                                Positioned(
                                  bottom: 15,
                                  right: 15,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 8),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 18,
                                            color: Colors.yellow,
                                          ),
                                          const Text(
                                            "4.5",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          customContainer(
                              width: width,
                              icon: ImagesPaths.ic_location,
                              title:
                                  _businessDetail?.businessData?.address ?? "",
                              onTap: () {}),
                          _businessDetail?.businessData?.phone != null &&
                                  _businessDetail?.businessData?.phone != ""
                              ? customContainer(
                                  width: width,
                                  icon: ImagesPaths.ic_phone,
                                  title: _businessDetail?.businessData?.phone ??
                                      "",
                                  onTap: () {
                                    launchUrl(
                                        Uri(
                                            scheme: 'tel',
                                            path: _businessDetail
                                                    ?.businessData?.phone ??
                                                ""),
                                        mode: LaunchMode.externalApplication);
                                  })
                              : SizedBox.shrink(),
                          _businessDetail?.businessData?.url != null &&
                                  _businessDetail?.businessData?.url?.trim() !=
                                      ""
                              ? customContainer(
                                  width: width,
                                  icon: ImagesPaths.ic_web,
                                  isWeb: true,
                                  title:
                                      _businessDetail?.businessData?.url ?? "",
                                  onTap: () {
                                    widget.setArgs!({
                                      "url":
                                          _businessDetail?.businessData?.url ??
                                              ""
                                    });
                                    widget.changeIndex!(7);
                                    // launchUrl(
                                    //   Uri(
                                    //     scheme: 'https',
                                    //     host: _businessDetail
                                    //             ?.businessData?.url ??
                                    //         "",
                                    //   ),
                                    //   mode: LaunchMode.externalApplication,
                                    // );
                                  })
                              : SizedBox.shrink(),
                          workingHoursWidget(
                              width: width,
                              isVisible: isVisible,
                              icon: ImagesPaths.ic_clock,
                              title: "Working Hours",
                              onTap: () {
                                setState(() {
                                  isVisible = isVisible == true ? false : true;
                                });
                              }),
                          isVisible
                              ? getTimings(_businessDetail, width)
                              : const SizedBox.shrink(),
                          Container(
                            color: AppColors.lightGrey,
                            height: 60,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: SingleChildScrollView(
                                            child: Form(
                                              key: _formKey,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(vertical: 8),
                                                    child: const Text(
                                                        "Send Enquiry"),
                                                  ),
                                                  TextFormField(
                                                    controller: nameController,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: "Name",
                                                      errorMaxLines: 2,
                                                    ),
                                                    validator: (value) => value!
                                                            .isEmpty
                                                        ? 'Name cannot be blank'
                                                        : null,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 4),
                                                          child: TextFormField(
                                                            controller:
                                                                emailController,
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  "Email",
                                                              errorMaxLines: 2,
                                                            ),
                                                            validator: (value) =>
                                                                value!.isEmpty
                                                                    ? 'Email cannot be blank'
                                                                    : null,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4),
                                                          child: TextFormField(
                                                            controller:
                                                                phoneController,
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  "Phone no.",
                                                              errorMaxLines: 2,
                                                            ),
                                                            validator: (value) =>
                                                                value!.isEmpty
                                                                    ? 'Phone no. cannot be blank'
                                                                    : null,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        messageController,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: "Message",
                                                      errorMaxLines: 2,
                                                    ),
                                                    validator: (value) => value!
                                                            .isEmpty
                                                        ? 'Message cannot be blank'
                                                        : null,
                                                    maxLines: 5,
                                                  ),
                                                  GestureDetector(
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          color: Color(Constants
                                                              .themeColorRed),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          16))),
                                                      margin:
                                                          const EdgeInsets.only(
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
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      if (validateAndSave()) {
                                                        sendEnquiry();
                                                      }
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.greenTheme),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            ImagesPaths.ic_send_enquiry,
                                            width: 20,
                                            color: Colors.white,
                                          ),
                                          const Text(
                                            " Send Enquiry",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.greenTheme),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          ImagesPaths.ic_send_enquiry,
                                          width: 20,
                                          color: Colors.white,
                                        ),
                                        const Text(
                                          " Send to Friend",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                                width: width - 50,
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  _businessDetail?.businessData?.name ?? "",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                                width: width - 50,
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  _businessDetail?.businessData?.description ??
                                      "",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      wordSpacing: -1),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Container(
                              height: 40,
                              width: 160,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(Constants.themeColorRed),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: SingleChildScrollView(
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  child: const Text(
                                                      "Claim This Business"),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 4),
                                                        child: TextFormField(
                                                          controller:
                                                              nameController,
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText: "Name",
                                                            errorMaxLines: 2,
                                                          ),
                                                          validator: (value) =>
                                                              value!.isEmpty
                                                                  ? 'Name cannot be blank'
                                                                  : null,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 4),
                                                        child: TextFormField(
                                                          controller:
                                                              emailController,
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText: "Email",
                                                            errorMaxLines: 2,
                                                          ),
                                                          validator: (value) =>
                                                              value!.isEmpty
                                                                  ? 'Email cannot be blank'
                                                                  : null,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                TextFormField(
                                                  controller: phoneController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: "Phone no.",
                                                    errorMaxLines: 2,
                                                  ),
                                                  validator: (value) => value!
                                                          .isEmpty
                                                      ? 'Phone no. cannot be blank'
                                                      : null,
                                                ),
                                                GestureDetector(
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                        color: Color(Constants
                                                            .themeColorRed),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    16))),
                                                    margin:
                                                        const EdgeInsets.only(
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
                                                      claimBusiness();
                                                    }
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 4),
                                    child: FittedBox(
                                      child: Text(
                                        "Own This Business?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Colors.white),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          getGallery(
                              _businessDetail?.businessData?.moreImages ?? ""),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget customContainer(
      {required String icon,
      required String title,
      required Function onTap,
      bool isWeb = false,
      required double width}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
        child: SizedBox(
          width: width,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(icon, width: 20),
              ),
              SizedBox(
                child: Row(
                  children: [
                    SizedBox(
                        width: width * .76,
                        child: Text(
                          isWeb ? "${title} (Click to visit)" : title,
                          style: TextStyle(
                              fontSize: 11, overflow: TextOverflow.ellipsis),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // .px(15).marginOnly(top: 10).onTap(() {
    //   onTap();
    // });
  }

  Widget dayWidget(
      {required String dayName, required String time, required double width}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: ((width - 16) / 3) * 0.25,
            decoration: BoxDecoration(color: Color(0xffDAE0EE)),
            child: Text(
              dayName,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Color(0xffEEF1F8)),
              child: Text(
                time ?? "NA - NA",
                style: TextStyle(fontSize: 8),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget workingHoursWidget(
      {required double width,
      required String icon,
      required String title,
      required Function onTap,
      required bool isVisible}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(top: 10),
        width: width,
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(icon, width: 20)),
            SizedBox(
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 11, overflow: TextOverflow.ellipsis),
                  ),
                  isVisible
                      ? const Icon(Icons.keyboard_arrow_down)
                      : const Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Could not launch $url';
    }
  }

  Widget getTimings(BusinessDetailResponseModel? businessDetail, double width) {
    final timings = [];
    final days = ["M", "T", "W", "T", "F", "S", "S"];
    Widget widget = SizedBox.shrink();
    try {
      timings.addAll(jsonDecode(businessDetail!.businessData!.timings!.trim()));
      widget = GridView.builder(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          // width / height: fixed for *all* items
          childAspectRatio: 4.0,
        ),
        itemBuilder: (context, i) {
          String opening = DateFormat('hh:mm a').format(
              DateTime.tryParse(timings[i]['opening']) ?? DateTime.now());
          String closing = DateFormat('hh:mm a').format(
              DateTime.tryParse(timings[i]['closing']) ?? DateTime.now());
          return dayWidget(
              width: width,
              dayName: days[i],
              time: '${opening + " - " + closing}');
        },
        itemCount: timings.length,
      );
    } catch (e) {
      print(e.toString());
    }
    return widget;
  }

  Widget getGallery(String img) {
    Widget widget = SizedBox.shrink();
    List<String> images = img.split(",");
    if (images.isNotEmpty) {
      widget = Container(
        height: 200,
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 32),
        child: ListView.builder(
          clipBehavior: Clip.none,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int idx) => Container(
            height: 200,
            width: 200,
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Image.network(
              "https://dubailocal.ae/assets/more_images/${images[idx]}",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            clipBehavior: Clip.hardEdge,
          ),
        ),
      );
    }
    return widget;
  }
}
