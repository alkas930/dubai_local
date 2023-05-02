import 'dart:convert';

import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/controllers/main_business_controllers.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/app_colors.dart';
import 'package:dubai_local/utils/localisations/images_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class MainBusinessUI extends StatelessWidget {
  MainBusinessUI({Key? key}) : super(key: key);

  MainBusinessControllers controllers = Get.put(MainBusinessControllers());

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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Obx(
        () => controllers.businessDetail.value.businessData == null
            ? SizedBox.shrink()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HeaderWidget(isBackEnabled: true),
                  "${controllers.businessDetail.value?.businessData?.name}"
                      .text
                      .white
                      .size(20)
                      .make()
                      .py(10),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Container(
                      alignment: Alignment.topCenter,
                      constraints: BoxConstraints(minHeight: Get.height),
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
                                  "${controllers.businessDetail.value?.businessData!.fullBanner}",
                                  fit: BoxFit.cover,
                                  width: Get.width,
                                  height: 150,
                                ),
                                "${controllers.businessDetail.value?.businessData?.name}"
                                    .text
                                    .semiBold
                                    .white
                                    .make()
                                    .px(15)
                                    .positioned(bottom: 15),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 18,
                                        color: Colors.yellow,
                                      ),
                                      "4.5"
                                          .text
                                          .size(15)
                                          .white
                                          .make()
                                          .marginOnly(left: 2)
                                    ],
                                  ).px(8).py(1),
                                ).positioned(bottom: 15, right: 15)
                              ],
                            ),
                          ),
                          customContainer(
                              icon: ImagesPaths.ic_location,
                              title:
                                  "${controllers.businessDetail.value?.businessData?.address}",
                              onTap: () {}),
                          customContainer(
                              icon: ImagesPaths.ic_phone,
                              title:
                                  "${controllers.businessDetail.value?.businessData?.phone}",
                              onTap: () {}),
                          customContainer(
                              icon: ImagesPaths.ic_web,
                              isWeb: true,
                              title:
                                  "${controllers.businessDetail.value?.businessData?.url}",
                              onTap: () {
                                launchUrl(
                                  Uri(
                                      scheme: 'https',
                                      host:
                                          '${controllers.businessDetail.value?.businessData?.url}',
                                      path: ''),
                                  mode: LaunchMode.externalApplication,
                                );
                              }),
                          workingHoursWidget(
                              icon: ImagesPaths.ic_clock,
                              title: "Working Hours",
                              onTap: () {
                                controllers.changeVisibility();
                              }),
                          Obx(() => !controllers.isVisible.value
                                  ? const SizedBox.shrink()
                                  : getTimings(controllers))
                              .px(15)
                              .marginOnly(top: 10),
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
                                  ).py(5).px(15),
                                ).onTap(() {
                                  controllers.onTapSendEnquiry();
                                }),
                                Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.greenTheme),
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
                                  ).py(5).px(15),
                                ).onTap(() {
                                  controllers.onTapSendEnquiry();
                                }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                                width: Get.width - 50,
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  "${controllers.businessDetail.value?.businessData?.name}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                                width: Get.width - 50,
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  "${controllers.businessDetail.value?.businessData?.description}",
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
                                child: const Text(
                                  "Own This Business?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Colors.white),
                                ).py(5).px(15),
                              ),
                            ).onTap(() {
                              controllers.onTapSendEnquiry();
                            }),
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
      bool isWeb = false}) {
    return SizedBox(
      width: Get.width,
      child: Row(
        children: [
          Image.asset(icon, width: 20).marginOnly(right: 10),
          SizedBox(
            child: Row(
              children: [
                SizedBox(
                    width: Get.width * .76,
                    child: "$title ${isWeb ? "(Click to visit)" : ""}"
                        .text
                        .size(11)
                        .overflow(TextOverflow.ellipsis)
                        .make()),
              ],
            ),
          ),
        ],
      ),
    ).px(15).marginOnly(top: 10).onTap(() {
      onTap();
    });
  }

  Widget dayWidget({required String dayName, required String time}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.center,
          width: ((Get.width - 16) / 3) * 0.25,
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
    ).marginSymmetric(vertical: 4, horizontal: 2);
  }

  Widget workingHoursWidget({
    required String icon,
    required String title,
    required Function onTap,
  }) {
    return SizedBox(
      width: Get.width,
      child: Row(
        children: [
          Image.asset(icon, width: 20).marginOnly(right: 10),
          SizedBox(
            child: Row(
              children: [
                title.text.size(11).overflow(TextOverflow.ellipsis).make(),
                Obx(() => controllers.isVisible.value
                    ? const Icon(Icons.keyboard_arrow_down)
                    : const Icon(Icons.keyboard_arrow_right)),
              ],
            ),
          ),
        ],
      ),
    ).px(15).marginOnly(top: 10).onTap(() {
      onTap();
    });
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Could not launch $url';
    }
  }

  Widget getTimings(MainBusinessControllers controllers) {
    final timings = [];
    final days = ["M", "T", "W", "T", "F", "S", "S"];
    Widget widget = SizedBox.shrink();
    try {
      timings.addAll(jsonDecode(
          controllers.businessDetail.value.businessData!.timings!.trim()));
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
              dayName: days[i], time: '${opening + " - " + closing}');
        },
        itemCount: timings.length,
      );
    } catch (e) {
      printError(info: e.toString());
    }
    return widget;
  }
}
