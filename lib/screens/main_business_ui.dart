// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/models/business_details_response_model.dart';
import 'package:dubai_local/services/networking_services/api_call.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/app_colors.dart';
import 'package:dubai_local/utils/localisations/images_paths.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:velocity_x/velocity_x.dart';

class MainBusinessUI extends StatefulWidget {
  final Function(int index)? changeIndex;
  final Function(Map args)? setArgs;
  final Function() onBack;
  final Function() returnToHome;
  final Map args;
  final bool isBackEnabled;

  const MainBusinessUI(
      {Key? key,
      required this.changeIndex,
      required this.setArgs,
      required this.onBack,
      required this.returnToHome,
      required this.isBackEnabled,
      required this.args})
      : super(key: key);

  @override
  State<MainBusinessUI> createState() => _MainBusinessUIState();
}

class _MainBusinessUIState extends State<MainBusinessUI>
    with TickerProviderStateMixin {
  int pageIndex = 0;
  double? _rating;
  IconData? _selectedIcon;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // SUBMIT REVIEW CONTROLLER
  final TextEditingController nameControllerReview = TextEditingController();
  final TextEditingController messageControllerReview = TextEditingController();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  BusinessDetailResponseModel? _businessDetail;
  bool isVisible = false;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool isLoading = true;
  double result = 0;
  void callAPI(String businessSlug, bool isSearch) {
    CallAPI()
        .getBusinessDetail(businessSlug: businessSlug, isSearch: isSearch)
        .then((value) {
      final marker = Marker(
        markerId: MarkerId(value.businessData!.name ?? ""),
        position: LatLng(double.parse(value.businessData!.lat.toString()),
            double.parse(value.businessData!.lng.toString())),
        // icon: BitmapDescriptor.,
        infoWindow: InfoWindow(
          title: value.businessData!.name ?? "",
          snippet: value.businessData!.address ?? "",
        ),
      );
      var stars = value.businessData?.average_rating;
      setState(() {
        markers[MarkerId(value.businessData!.name ?? "")] = marker;
        _businessDetail = value;
        isLoading = false;
        result = double.parse(stars!);
      });
    });
  }

  void submitReview() {
    CallAPI().SubmitReview(body: {
      "business_id": _businessDetail?.businessData?.id,
      "business_name": _businessDetail?.businessData?.name,
      "rating": _rating?.toStringAsFixed(1),
      "review_text": messageControllerReview.text,
      "name": nameControllerReview.text
    }).then((value) {
      if (value == null) {
        ToastContext().init(context);
        Toast.show("Something went wrong");
      } else {
        messageControllerReview.clear();
        nameControllerReview.clear();
        ToastContext().init(context);
        _rating = 0;
        Toast.show(value["message"] ?? "Review submitted.", duration: 5);
      }
    }).catchError((onError) {});
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

  void claimBusiness() {
    CallAPI().claimBusiness(body: {
      "name": nameController.text,
      "email": emailController.text,
      "phone_no": phoneController.text,
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
        ToastContext().init(context);
        Toast.show(value["message"] ?? "Claim raised successfully",
            duration: 5);
      }
    }).catchError((onError) {});
  }

  double getRating(double? rating, double avgRating) {
    if (rating == null) {
    } else {}
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
    // ignore: no_leading_underscores_for_local_identifiers
    final PageController pageController = PageController();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    // final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;hl

    // ignore: no_leading_underscores_for_local_identifiers
    Future<bool> _onWillPop() async {
      // Navigator.pop(context);
      widget.onBack();
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.topCenter,
        constraints: BoxConstraints(minHeight: height, maxHeight: height),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: isLoading
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
                    height: height * 0.18,
                    child: Stack(
                      children: [
                        Image.network(
                          _businessDetail?.businessData?.fullBanner ?? "",
                          fit: BoxFit.cover,
                          width: width,
                          height: height * 0.18,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black54],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        // HeaderWidget(
                        //   isBackEnabled: true,
                        //   changeIndex: widget.changeIndex,
                        //   onBack: widget.onBack,
                        //   returnToHome: widget.returnToHome,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: SizedBox(
                              width: Constants.iconSize,
                              height: Constants.iconSize,
                              child: widget.isBackEnabled
                                  ? GestureDetector(
                                      onTap: () {
                                        // Navigator.pop(context);
                                        widget.onBack();
                                      },
                                      child: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ),
                                    )
                                  : null),
                        ),
                        Positioned(
                          bottom: 15,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  _businessDetail?.businessData?.name ?? "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColors.greenTheme,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1, horizontal: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        " ${result.toStringAsFixed(1)}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // TABBAR
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            pageController.animateToPage(0,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.linear);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: pageIndex == 0
                                        ? Color(0xff1D1810)
                                        : Color(0xffEEF1F8),
                                    width: 3.0,
                                  ),
                                ),
                                color: pageIndex == 0
                                    ? AppColors.greenTheme
                                    : const Color(0xffEEF1F8)),
                            child: Text("About",
                                style: TextStyle(
                                    color: pageIndex == 0
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12)),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        width: 1,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            pageController.animateToPage(1,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.linear);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: pageIndex == 1
                                        ? Color(0xff1D1810)
                                        : Color(0xffEEF1F8),
                                    width: 3.0,
                                  ),
                                ),
                                color: pageIndex == 1
                                    ? AppColors.greenTheme
                                    : const Color(0xffEEF1F8)),
                            child: Text("Get Direction",
                                style: TextStyle(
                                    color: pageIndex == 1
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12)),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        width: 1,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            pageController.animateToPage(2,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.linear);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: pageIndex == 2
                                        ? Color(0xff1D1810)
                                        : Color(0xffEEF1F8),
                                    width: 3.0,
                                  ),
                                ),
                                color: pageIndex == 2
                                    ? AppColors.greenTheme
                                    : const Color(0xffEEF1F8)),
                            child: Text("Post a Review",
                                style: TextStyle(
                                    color: pageIndex == 2
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: PageView(
                      onPageChanged: (value) {
                        setState(() {
                          pageIndex = value;
                        });
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      children: [
                        // ABOUT
                        aboutContent(width, context, height),
                        // GOOGLE MAP
                        GoogleMap(
                          liteModeEnabled: Platform.isAndroid ? true : false,
                          markers: markers.values.toSet(),
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                double.parse(_businessDetail!.businessData!.lat
                                    .toString()),
                                double.parse(_businessDetail!.businessData!.lng
                                    .toString())),
                            zoom: 18.5,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        ),
                        // SUBMIT REVIEW
                        Container(
                          color: AppColors.lightGrey,
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      color:
                                          const Color(Constants.themeColorRed),
                                      height: 80,
                                      width: 80,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            result.toStringAsFixed(1),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          VxRating(
                                            onRatingUpdate: (v) {},
                                            size: 10,
                                            normalColor: AppColors.grey,
                                            selectionColor: AppColors.yellow,
                                            maxRating: 5,
                                            count: 5,
                                            value: result,
                                            isSelectable: false,
                                          ),
                                        ],
                                      )),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: _rating ?? 0.0,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: false,
                                          itemCount: 5,
                                          itemSize: 22,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 5),
                                          itemBuilder: (context, _) => Icon(
                                            _selectedIcon ?? Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            _rating = rating;
                                          },
                                        ),
                                        const Text(
                                          "Click on stars to give rating",
                                          style: TextStyle(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: TextFormField(
                                          controller: nameControllerReview,
                                          decoration: const InputDecoration(
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            labelText: "Enter Name*",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            errorMaxLines: 2,
                                          ),
                                          validator: (value) => value!.isEmpty
                                              ? 'Please enter your name'
                                              : null,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: TextFormField(
                                          controller: messageControllerReview,
                                          decoration: const InputDecoration(
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              labelText: "Your Message*",
                                              labelStyle: TextStyle(
                                                  color: Colors.black)),
                                          validator: (value) => value!.isEmpty
                                              ? 'Please enter your review'
                                              : null,
                                          maxLines: 5,
                                          minLines: 1,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: double.infinity,
                                        child: SubmitReviewButton(
                                          onPressed: () => {
                                            if (validateAndSave())
                                              {submitReview()}
                                          },
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                      // onPageChanged: (value) => setState(() {
                      //   _pageIndex = value;
                      // }),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Column aboutContent(double width, BuildContext context, double height) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        customContainer(
            width: width,
            icon: ImagesPaths.ic_location,
            title: _businessDetail?.businessData?.address ?? "",
            onTap: () {}),
        _businessDetail?.businessData?.phone != null &&
                _businessDetail?.businessData?.phone != ""
            ? customContainer(
                width: width,
                icon: ImagesPaths.ic_phone,
                title: _businessDetail?.businessData?.phone ?? "",
                onTap: () {
                  launchUrl(
                      Uri(
                          scheme: 'tel',
                          path: _businessDetail?.businessData?.phone ?? ""),
                      mode: LaunchMode.externalApplication);
                })
            : const SizedBox.shrink(),
        _businessDetail?.businessData?.url != null &&
                _businessDetail?.businessData?.url?.trim() != ""
            ? customContainer(
                width: width,
                icon: ImagesPaths.ic_web,
                isWeb: true,
                title: _businessDetail?.businessData?.url ?? "",
                onTap: () {
                  widget.setArgs!(
                      {"url": _businessDetail?.businessData?.url ?? ""});
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
            : const SizedBox.shrink(),
        workingHoursWidget(
            width: width,
            isVisible: isVisible,
            icon: ImagesPaths.ic_clock,
            title: "Working Hours",
            onTap: () {
              // setState(() {
              //   isVisible = isVisible == true ? false : true;
              // });
            }),
        // isVisible
        //     ?
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: getTimings(_businessDetail, width),
        ),
        // : const SizedBox.shrink(),
        Container(
          // color: AppColors.lightGrey,
          // height: 60,
          margin: const EdgeInsets.only(top: 8, bottom: 8),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
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
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              child: const Text("Send Enquiry"),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
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
                                          _businessDetail?.businessData?.name ??
                                              "",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
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
                                            !RegExp(r"^[a-zA-Z\s]+$")
                                                .hasMatch(value)
                                        ? 'Please enter a valid name'
                                        : null,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 4),
                                          child: TextFormField(
                                            controller: emailController,
                                            decoration: const InputDecoration(
                                              labelText: "Enter Email",
                                              errorMaxLines: 2,
                                            ),
                                            validator: (value) => value!
                                                        .isEmpty ||
                                                    !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                        .hasMatch(value)
                                                ? 'Please enter valid email'
                                                : null,
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 4),
                                          child: TextFormField(
                                            controller: phoneController,
                                            decoration: const InputDecoration(
                                              labelText: "Enter Phone",
                                              errorMaxLines: 2,
                                            ),
                                            validator: (value) => value!
                                                            .length >
                                                        15 ||
                                                    value.length < 9
                                                ? 'Please enter valid phone no.'
                                                : null,
                                            style:
                                                const TextStyle(fontSize: 14),
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
                                    validator: (value) => value!.isEmpty
                                        ? 'Message cannot be blank'
                                        : null,
                                    maxLines: 3,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Color(Constants.themeColorRed),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
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
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.greenTheme),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      children: [
                        Image.asset(
                          ImagesPaths.ic_send_enquiry,
                          width: 12,
                          color: Colors.white,
                        ),
                        const Text(
                          " Send Enquiry",
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
              SizedBox(
                width: 16,
              ),
              GestureDetector(
                onTap: () {
                  Share.share(
                      "https://dubailocal.ae/business/${_businessDetail?.businessData?.slug ?? ""}",
                      subject: _businessDetail?.businessData?.name ?? "");
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.greenTheme),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      children: [
                        Image.asset(
                          ImagesPaths.ic_send_enquiry,
                          width: 12,
                          color: Colors.white,
                        ),
                        const Text(
                          " Send to Friend",
                          style: TextStyle(
                              fontSize: 10,
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        child: Text(
                          _businessDetail?.businessData?.description ?? "",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              width: 160,
              padding: EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.greenTheme,
              ),
              child: const FittedBox(
                child: Text(
                  "Show Description",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
        // Expanded(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 8),
        //     child: Scrollbar(
        //       thumbVisibility: true,
        //       child: SingleChildScrollView(
        //         child: Text(
        //           _businessDetail?.businessData?.description ?? "",
        //           style: const TextStyle(fontSize: 10),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        getGallery(_businessDetail?.businessData?.moreImages ?? "", height),
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Container(
            width: 160,
            padding: EdgeInsets.symmetric(vertical: 8),
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
                        child: SizedBox(
                          width: width,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: const Text(
                                                "Claim This Business"),
                                          ),
                                          Positioned(
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
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
                                        _businessDetail?.businessData?.name ??
                                            "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 4),
                                        child: TextFormField(
                                          controller: nameController,
                                          decoration: const InputDecoration(
                                            labelText: "Enter Name",
                                            errorMaxLines: 2,
                                          ),
                                          validator: (value) =>
                                              value!.isEmpty ||
                                                      !RegExp(r"^[a-zA-Z\s]+$")
                                                          .hasMatch(value)
                                                  ? 'Please enter a valid name'
                                                  : null,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 4),
                                        child: TextFormField(
                                          controller: emailController,
                                          decoration: const InputDecoration(
                                            labelText: "Enter Email",
                                            errorMaxLines: 2,
                                          ),
                                          validator: (value) => value!
                                                      .isEmpty ||
                                                  !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                      .hasMatch(value)
                                              ? 'Please enter valid email'
                                              : null,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TextFormField(
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
                                GestureDetector(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Color(Constants.themeColorRed),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
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
                                      claimBusiness();
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
              child: const FittedBox(
                child: Text(
                  "Own This Business?",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget customContainer({
    required String icon,
    required String title,
    required Function onTap,
    bool isWeb = false,
    required double width,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
        child: SizedBox(
          width: width,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  icon,
                  width: 14,
                  color: const Color(0xffEA545A),
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    SizedBox(
                      width: width * .76,
                      child: Text(
                        isWeb ? "$title" : title,
                        style: TextStyle(
                            fontSize: 11,
                            overflow: TextOverflow.ellipsis,
                            fontWeight:
                                isWeb ? FontWeight.bold : FontWeight.normal,
                            color: isWeb ? Colors.blue.shade800 : Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dayWidget(
      {required String dayName, required String time, required double width}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      width: ((width - 16) / 3),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: ((width - 16) / 3) * 0.2,
            decoration: const BoxDecoration(color: Color(0xffDAE0EE)),
            child: Text(
              dayName,
              style: const TextStyle(
                fontSize: 10,
                // fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: Color(0xffEEF1F8)),
              child: FittedBox(
                child: Text(
                  time,
                  style: const TextStyle(fontSize: 8),
                  textAlign: TextAlign.center,
                ),
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.only(top: 10),
        width: width,
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  icon,
                  width: 14,
                  color: Color(0xffEA545A),
                )),
            SizedBox(
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 11, overflow: TextOverflow.ellipsis),
                  ),
                  // isVisible
                  //     ? const Icon(Icons.keyboard_arrow_down)
                  //     : const Icon(Icons.keyboard_arrow_right),
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
    Widget widget = const SizedBox.shrink();
    try {
      timings.addAll(jsonDecode(businessDetail!.businessData!.timings!.trim()));
      widget = SizedBox(
        height: 25,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 3,
          //   // width / height: fixed for *all* items
          //   childAspectRatio: 4.0,
          // ),
          itemBuilder: (context, i) {
            String opening = DateFormat('hh:mm a').format(
                DateTime.tryParse(timings[i]['opening']) ?? DateTime.now());
            String closing = DateFormat('hh:mm a').format(
                DateTime.tryParse(timings[i]['closing']) ?? DateTime.now());
            return dayWidget(
                width: width, dayName: days[i], time: "$opening - $closing");
          },
          itemCount: timings.length,
        ),
      );
    } catch (e) {}
    return widget;
  }

  Widget getGallery(String img, double height) {
    Widget widget = const SizedBox.shrink();
    List<String> images = img.split(",");
    if (images.isNotEmpty) {
      widget = Container(
        height: height * 0.15,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.only(top: 16),
        child: ListView.builder(
          clipBehavior: Clip.none,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int idx) => Container(
            height: height * 0.15,
            width: height * 0.15,
            margin: const EdgeInsets.only(right: 16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            clipBehavior: Clip.hardEdge,
            child: GestureDetector(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (_) => ImageDialog(
                      image:
                          "https://dubailocal.ae/assets/more_images/${images[idx]}"),
                );
              },
              child: Image.network(
                "https://dubailocal.ae/assets/more_images/${images[idx]}",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ),
      );
    }
    return widget;
  }
}

class ImageDialog extends StatelessWidget {
  final String image;
  const ImageDialog({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _transformationController = TransformationController();
    late TapDownDetails _doubleTapDetails;

    handleDoubleTap() {
      if (_transformationController.value != Matrix4.identity()) {
        _transformationController.value = Matrix4.identity();
      } else {
        final position = _doubleTapDetails.localPosition;
        // For a 3x zoom
        _transformationController.value = Matrix4.identity()
          ..translate(-position.dx * 2, -position.dy * 2)
          ..scale(3.0);
        // Fox a 2x zoom
        // ..translate(-position.dx, -position.dy)
        // ..scale(2.0);
      }
    }

    return Stack(children: [
      Align(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: GestureDetector(
            onDoubleTapDown: (d) => _doubleTapDetails = d,
            onDoubleTap: handleDoubleTap,
            child: InteractiveViewer(
              transformationController: _transformationController,
              child: Image.network(image),
            ),
          ),
        ),
      ),
      Positioned(
          right: 15,
          top: 15,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          )),
    ]);
  }
}

class SubmitReviewButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SubmitReviewButton({super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(primary: AppColors.greenTheme),
        child: const Text('Submit Review'));
  }
}
