import 'dart:convert';

import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/models/business_details_response_model.dart';
import 'package:dubai_local/services/networking_services/api_call.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/app_colors.dart';
import 'package:dubai_local/utils/localisations/images_paths.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

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
  BusinessDetailResponseModel? _businessDetail;

  void callAPI(String businessSlug) {
    CallAPI().getBusinessDetail(businessSlug: businessSlug).then((value) {
      setState(() {
        _businessDetail = value;
      });
    });
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
      callAPI(widget.args["slug"] ?? "");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    // final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;

    bool isVisible = false;
    Future<bool> _onWillPop() async {
      // Navigator.pop(context);
      widget.onBack();
      return false;
    }

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
                                Positioned(
                                  bottom: 15,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      _businessDetail?.businessData?.name ?? "",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
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
                          customContainer(
                              width: width,
                              icon: ImagesPaths.ic_phone,
                              title: _businessDetail?.businessData?.phone ?? "",
                              onTap: () {}),
                          customContainer(
                              width: width,
                              icon: ImagesPaths.ic_web,
                              isWeb: true,
                              title: _businessDetail?.businessData?.url ?? "",
                              onTap: () {
                                launchUrl(
                                  Uri(
                                      scheme: 'https',
                                      host:
                                          _businessDetail?.businessData?.url ??
                                              "",
                                      path: ''),
                                  mode: LaunchMode.externalApplication,
                                );
                              }),
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
                                          " Send Enquiry",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ],
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
                              child: Container(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: const Text(
                                    "Own This Business?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Colors.white),
                                  ),
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
    );
  }

  Widget customContainer(
      {required String icon,
      required String title,
      required Function onTap,
      bool isWeb = false,
      required double width}) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
      child: SizedBox(
        width: width,
        child: Row(
          children: [
            Image.asset(icon, width: 20),
            SizedBox(
              child: Row(
                children: [
                  SizedBox(
                      width: width * .76,
                      child: Text(
                        isWeb ? "(Click to visit)" : "",
                        style: TextStyle(
                            fontSize: 11, overflow: TextOverflow.ellipsis),
                      )),
                ],
              ),
            ),
          ],
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
        // padding: padding,
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
}
