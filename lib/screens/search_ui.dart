import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/app_colors.dart';
import 'package:dubai_local/utils/search_widget.dart';
import 'package:flutter/material.dart';
import '../utils/localisations/images_paths.dart';

class SearchUi extends StatelessWidget {
  const SearchUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            const HeaderWidget(isBackEnabled: false),
            Text(
              "Search Results",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Container(
              width: width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SearchWidget(isLight: false),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget items({required SearchItems searchItems}) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8.0, bottom: 8),
  //     child: Container(
  //       width: Get.width * .8,
  //       height: 135,
  //       decoration: BoxDecoration(
  //           color: AppColors.white, borderRadius: BorderRadius.circular(15)),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               Container(
  //                 height: 50,
  //                 width: Get.width * .14,
  //                 decoration: BoxDecoration(
  //                   color: Colors.red,
  //                   borderRadius: BorderRadius.circular(70),
  //                 ),
  //                 child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(70),
  //                     child: Image.network("${searchItems.itemsImages}",
  //                         fit: BoxFit.cover)),
  //               ).pOnly(bottom: 50, left: 5),
  //               Container(
  //                   alignment: Alignment.topLeft,
  //                   width: Get.width * .80,
  //                   color: Colors.white,
  //                   child: Column(
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           SizedBox(
  //                             width: Get.width * .5,
  //                             child: "${searchItems.title}"
  //                                 .text
  //                                 .size(3)
  //                                 .color(Colors.grey.shade700)
  //                                 .fontWeight(FontWeight.w500)
  //                                 .make(),
  //                           ),
  //                           Container(
  //                             height: 30,
  //                             alignment: Alignment.topRight,
  //                             child: Row(
  //                               children: [
  //                                 VxRating(
  //                                   onRatingUpdate: (v) {},
  //                                   size: 10,
  //                                   normalColor: AppColors.grey,
  //                                   selectionColor: AppColors.yellow,
  //                                   count: 4,
  //                                   value: 3.4,
  //                                 ),
  //                                 Container(
  //                                   alignment: Alignment.center,
  //                                   height: 16,
  //                                   width: Get.width * .13,
  //                                   decoration: BoxDecoration(
  //                                       color: Colors.green,
  //                                       borderRadius:
  //                                           BorderRadius.circular(10)),
  //                                   child: "${searchItems.ratingValue}"
  //                                       .text
  //                                       .size(5)
  //                                       .color(Colors.white)
  //                                       .make(),
  //                                 )
  //                               ],
  //                             ),
  //                           )
  //                         ],
  //                       ).pOnly(left: 10, top: 10),
  //                       Container(
  //                         height: 1,
  //                         width: Get.width,
  //                         color: Colors.grey,
  //                       ).pOnly(top: 5, left: 10),
  //                       Row(
  //                         children: [
  //                           const Icon(Icons.location_on_outlined,
  //                               size: 17, color: Colors.black),
  //                           SizedBox(
  //                             width: Get.width * .7,
  //                             child: "${searchItems.address}"
  //                                 .text
  //                                 .color(Colors.grey.shade600)
  //                                 .size(5)
  //                                 .make(),
  //                           ).pOnly(left: 5)
  //                         ],
  //                       ).pOnly(top: 10, right: 5),
  //                       Row(
  //                         children: [
  //                           const Icon(
  //                             Icons.phone,
  //                             size: 17,
  //                             color: Colors.black,
  //                           ),
  //                           "${searchItems.phoneNumber}"
  //                               .text
  //                               .color(Colors.grey.shade600)
  //                               .make()
  //                               .pOnly(left: 5)
  //                         ],
  //                       ).pOnly(right: 5)
  //                     ],
  //                   )).pOnly(bottom: 20),
  //             ],
  //           ),
  //         ],
  //       ).pOnly(
  //         top: 10,
  //       ),
  //     ),
  //   );
  // }
}
