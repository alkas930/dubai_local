import 'package:cached_network_image/cached_network_image.dart';
import 'package:dubai_local/controllers/detail_controllers.dart';
import 'package:dubai_local/controllers/home_controller.dart';
import 'package:dubai_local/models/SubCategoryBusinessResponseModel.dart';
import 'package:dubai_local/services/networking_services/endpoints.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/localisations/app_colors.dart';
import '../utils/localisations/images_paths.dart';

class DetailUi extends StatelessWidget {
  const DetailUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailController controller = Get.find();
    HomeController homeController = Get.find();
    Future<bool> _onWillPop() async {
      homeController.changeIndex(homeController.lastIndex);
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const HeaderWidget(isBackEnabled: true),
              Obx(
                () => controller.placeName.value.text
                    .color(Colors.white)
                    .size(20)
                    .make()
                    .pOnly(top: 30, bottom: 20),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Column(
                  children: [
                    GetBuilder<DetailController>(
                        id: controller.updateListKey,
                        builder: (context) {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: controller.detailList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return items(
                                    searchItems: controller.detailList[index]);
                              });
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget items({required SubcatBusinessData searchItems}) {
    const double cardHeight = 96;
    const double imageRatio = 0.8; // 0 - min, 1 - max
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 8,
        shadowColor: Colors.black,
        color: Color(0xffF7F7F7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: cardHeight,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: cardHeight * imageRatio,
                      width: cardHeight * imageRatio,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 4),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
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
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                child: Row(
                                  children: [
                                    VxRating(
                                      onRatingUpdate: (v) {},
                                      size: 10,
                                      normalColor: AppColors.grey,
                                      selectionColor: AppColors.yellow,
                                      maxRating: 5,
                                      count: 5,
                                      value: searchItems.avgRating != null
                                          ? double.parse(double.parse(
                                                  searchItems.avgRating!)
                                              .toStringAsFixed(2))
                                          : 0,
                                      isSelectable: false,
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 8),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                            color: Color(0xff87B43D),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Text(
                                          "${double.tryParse(searchItems.avgRating!) ?? 0.toStringAsFixed(1)}",
                                          style: TextStyle(
                                              fontSize: 6,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Image.asset(
                                  ImagesPaths.ic_location,
                                  color: Color(0xff818181),
                                  width: 12,
                                  height: 12,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Text(
                                    searchItems.address!,
                                    style: TextStyle(
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
                                color: Color(0xff818181),
                                width: 12,
                                height: 12,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Text(
                                  searchItems.phone!,
                                  style: TextStyle(
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
