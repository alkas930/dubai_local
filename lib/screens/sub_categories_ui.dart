import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/models/sub_categories_response_model.dart';
import 'package:dubai_local/services/networking_services/api_call.dart';
import 'package:dubai_local/theme_controller.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:dubai_local/utils/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoriesUI extends StatefulWidget {
  final Function(int index)? changeIndex;
  final Function(Map args)? setArgs;
  final Function() onBack;
  final Function() returnToHome;
  final Map args;

  const SubCategoriesUI(
      {Key? key,
      required this.changeIndex,
      required this.setArgs,
      required this.onBack,
      required this.returnToHome,
      required this.args})
      : super(key: key);

  @override
  State<SubCategoriesUI> createState() => _SubCategoriesUIState();
}

class _SubCategoriesUIState extends State<SubCategoriesUI> {
  List<SubcatData> subCategoryList = [];

  callApi(String slug) {
    CallAPI().getSubCategories(slug: slug).then((value) {
      setState(() {
        subCategoryList = value.subCatData;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final Map args =
      //     (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
      callApi(widget.args["slug"] ?? "");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    void openSubCategoryBusiness(
        BuildContext context, String subCategory, String slug) {
      // Navigator.pushNamed(context, AppRoutes.detail, arguments: {
      //   "catName": args["catName"],
      //   "subCat": subCategory,
      //   "slug": slug
      // });
      widget.setArgs!({
        "catName": widget.args["catName"],
        "subCat": subCategory,
        "slug": slug
      });
      widget.changeIndex!(6);
    }

    Future<bool> _onWillPop() async {
      // Navigator.pop(context);
      widget.onBack();
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderWidget(
              isBackEnabled: true,
              changeIndex: widget.changeIndex,
              onBack: widget.onBack,
              returnToHome: widget.returnToHome,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 5),
              child: Text(
                widget.args["catName"] ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),
            ),
            // .text
            //     .color(Colors.white)
            //     .size(20)
            //     .make()
            //     .pOnly(top: 30, bottom: 20),
            SearchWidget(
              isLight: true,
              changeIndex: widget.changeIndex,
              setArgs: widget.setArgs,
            ),
            Container(
              width: width,
              constraints: BoxConstraints(minHeight: 0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: subCategoryList.length,
                itemBuilder: (_, int index) {
                  return items(
                      context: context,
                      categoryItem: subCategoryList[index],
                      index: index,
                      openSubCategoryBusiness: openSubCategoryBusiness);
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 5 / 4.5,
                    mainAxisSpacing: 20 / 2,
                    crossAxisSpacing: 10),
              ),
              // .marginOnly(top: 10, bottom: 30);
            ),
          ],
        ),
      ),
    );
  }

  Widget items(
      {required BuildContext context,
      required SubcatData categoryItem,
      required int index,
      required Function openSubCategoryBusiness}) {
    ThemeController themeController = Get.put(ThemeController());
    return Obx(
      () => InkButton(
        rippleColor: const Color(Constants.themeColorRed),
        backGroundColor: themeController.isDark.value
            ? const Color.fromARGB(255, 36, 36, 36)
            : Colors.white,
        borderRadius: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 35, child: Image.network(categoryItem.fullIcon!)),
            const SizedBox(
              height: 5,
            ),
            Text(
              categoryItem.subCatName!,
              style: TextStyle(
                color:
                    themeController.isDark.value ? Colors.white : Colors.black,
                fontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        onTap: () {
          openSubCategoryBusiness(
              context, categoryItem.subCatName, categoryItem.slug);
        },
      ),
    );
  }
}
