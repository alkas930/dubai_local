import 'dart:ffi';

import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/models/all_categories_response_model.dart';
import 'package:dubai_local/models/top_home_response_model.dart';
import 'package:dubai_local/theme_controller.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import '../utils/localisations/app_colors.dart';
import '../utils/search_widget.dart';

class CategoriesUi extends StatelessWidget {
  final Function(int index)? changeIndex;
  final Function(Map args)? setArgs;
  final List<AllCategoriesData> categoryList;
  final List<TopHomeData> topList;
  final Function() onBack;
  final Function() returnToHome;
  final Map args;

  const CategoriesUi(
      {Key? key,
      required this.categoryList,
      required this.topList,
      required this.changeIndex,
      required this.onBack,
      required this.returnToHome,
      required this.setArgs,
      required this.args})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openSubCategory(BuildContext context, String catName, String slug) {
      // Navigator.pushNamed(context, AppRoutes.subCategories,
      //     arguments: {"catName": catName, "slug": slug});
      setArgs!({"catName": catName, "slug": slug});
      changeIndex!(5);
    }

    Future<bool> _onWillPop() async {
      // Navigator.pop(context);
      onBack();
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            HeaderWidget(
              isBackEnabled: false,
              changeIndex: changeIndex,
              returnToHome: returnToHome,
              onBack: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
              ),
              child: Text(
                "Categories",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),
            ),
            SearchWidget(
              isLight: false,
              changeIndex: changeIndex,
              setArgs: setArgs,
            ),
            GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: categoryList.length,
                itemBuilder: (_, int index) {
                  return items(
                      context: context,
                      categoryItems: categoryList[index],
                      openSubCategory: openSubCategory);
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 10 / 6))
            // .marginOnly(top: 10, bottom: 30).pOnly(bottom: 48),
          ],
        ),
      ),
    );
  }

  Widget items(
      {required BuildContext context,
      required AllCategoriesData categoryItems,
      required Function openSubCategory}) {
    ThemeController themeController = Get.put(ThemeController());
    return Obx(
      () => InkButton(
        rippleColor: Color(Constants.themeColorRed),
        backGroundColor: themeController.isDark.value
            ? const Color.fromARGB(255, 36, 36, 36)
            : Colors.white,
        borderRadius: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 35, child: Image.network(categoryItems.fullIcon)),
            const SizedBox(
              height: 5,
            ),
            Text(
              categoryItems.name,
              style: TextStyle(
                color: themeController.isDark.value
                    ? Color.fromARGB(255, 252, 250, 250)
                    : Colors.black,
                fontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        onTap: () {
          openSubCategory(
            context,
            categoryItems.name,
            categoryItems.slug,
          );
        },
      ),
    );
  }
}
