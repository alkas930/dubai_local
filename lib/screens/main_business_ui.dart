import 'package:cached_network_image/cached_network_image.dart';
import 'package:dubai_local/controllers/main_business_controllers.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:dubai_local/utils/localisations/images_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class MainBusinessUI extends StatelessWidget {
  MainBusinessUI({Key? key}) : super(key: key);

  MainBusinessControllers controllers = Get.put(MainBusinessControllers());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagesPaths.img_bg),
              fit: BoxFit.fill,
            ),
          ),
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              const HeaderWidget(isBackEnabled: true),
              "Indian Foods".text.white.size(20).make().py(10),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Container(
                  width: Get.width * .95,
                  height: Get.height * .81,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: Stack(
                          children: [
                            Image.network(
                              "https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png",
                              fit: BoxFit.cover,
                              width: Get.width,
                              height: 150,
                            ),
                            "The Crossing"
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
                              "H Dubai - 1 Sheikh Zayed Rd- Dubai - United Arab Emirates",
                          onTap: () {}),
                      customContainer(
                          icon: ImagesPaths.ic_phone,
                          title: "+971449154563",
                          onTap: () {}),
                      customContainer(
                          icon: ImagesPaths.ic_web,
                          isWeb: true,
                          title: "www.crossingtherestaurant.com",
                          onTap: () {
                            launchUrl(
                              Uri(
                                  scheme: 'https',
                                  host: 'www.crossingtherestaurant.com',
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
                          ? SizedBox()
                          : Column(
                              children: [
                                dayWidget(
                                    dayName: "Monday",
                                    time: "18:00 hrs - 18:00 hrs"),
                                dayWidget(
                                    dayName: "Tuesday",
                                    time: "18:00 hrs - 18:00 hrs"),
                                dayWidget(
                                    dayName: "Wednesday",
                                    time: "18:00 hrs - 18:00 hrs"),
                                dayWidget(
                                    dayName: "Thursday",
                                    time: "18:00 hrs - 18:00 hrs"),
                                dayWidget(
                                    dayName: "Friday",
                                    time: "18:00 hrs - 18:00 hrs"),
                                dayWidget(
                                    dayName: "Satday",
                                    time: "18:00 hrs - 18:00 hrs"),
                              ],
                            )).marginOnly(top: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green.shade700),
                            child: Row(
                              children: [
                                Image.asset(
                                  ImagesPaths.ic_send_enquiry,
                                  width: 20,
                                  color: Colors.white,
                                ),
                                "SEND ENQUIRY"
                                    .text
                                    .fontWeight(FontWeight.w600)
                                    .make()
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
                                color: Colors.green.shade700),
                            child: Row(
                              children: [
                                Image.asset(
                                  ImagesPaths.ic_send_enquiry,
                                  width: 20,
                                  color: Colors.white,
                                ),
                                "SEND ENQUIRY"
                                    .text
                                    .fontWeight(FontWeight.w600)
                                    .make()
                              ],
                            ).py(5).px(15),
                          ).onTap(() {
                            controllers.onTapSendToFriend();
                          }),
                        ],
                      ).marginOnly(top: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
                Container(
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
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 35,
            color: Colors.grey,
            width: Get.width * .4,
            alignment: Alignment.centerLeft,
            child: dayName.text.make(),
          ),
          (time ?? "18:00 hrs - 18:00 hrs").text.make(),
        ],
      ),
    ).px(5);
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
                    : Icon(Icons.keyboard_arrow_right)),
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
}
