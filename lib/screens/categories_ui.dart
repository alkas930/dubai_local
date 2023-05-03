import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/models/all_categories_response_model.dart';
import 'package:dubai_local/models/top_home_response_model.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';
import '../utils/localisations/app_colors.dart';
import '../utils/search_widget.dart';

class CategoriesUi extends StatelessWidget {
  final List<AllCategoriesData> categoryList;
  final List<TopHomeData> topList;
  const CategoriesUi(
      {Key? key, required this.categoryList, required this.topList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openSubCategory(BuildContext context, String catName, String slug) {
      Navigator.pushNamed(context, AppRoutes.subCategories,
          arguments: {"catName": catName, "slug": slug});
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const HeaderWidget(isBackEnabled: false),
          const Text(
            "Categories",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SearchWidget(isLight: false),
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
    );
  }

  Widget items(
      {required BuildContext context,
      required AllCategoriesData categoryItems,
      required Function openSubCategory}) {
    return InkButton(
      rippleColor: const Color(Constants.themeColorRed),
      backGroundColor: const Color(0xffEEF2F3),
      borderRadius: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 35,
            child: ScalableImageWidget.fromSISource(
              si: ScalableImageSource.fromSvgHttpUrl(
                  Uri.parse(categoryItems.fullIcon)),
              onLoading: (ctx) {
                return SizedBox(
                    child: CircularProgressIndicator(
                  color: AppColors.accentRipple,
                ));
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            categoryItems.name,
            style: const TextStyle(
              color: Color(0xff333333),
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
    );
  }
}
