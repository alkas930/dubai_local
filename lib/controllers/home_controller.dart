import 'package:dubai_local/controllers/detail_controllers.dart';
import 'package:dubai_local/controllers/sub_category_controller.dart';
import 'package:get/get.dart';

import '../models/all_categories_response_model.dart';

class HomeController extends SuperController {
  List<AllCategoriesData> homeCategoryList = [];
  String webViewURL = "https://dubailocal.ae";
  String subCatSlug = "";
  String subBusiness = "";
  String subCatBusinessSlug = "";
  String subCatName = "";
  RxInt bottomIndex = 2.obs;
  int lastIndex = 2;

  void changeIndex(int index) {
    bottomIndex.value = index;
  }

  void getBack() {
    bottomIndex.value = lastIndex;
  }

  void openSubCategory(int lastIndex) {
    Get.put(SubCategoryController());
    SubCategoryController controller = Get.find();
    controller.callAPI();
    this.lastIndex = lastIndex;
    changeIndex(6);
  }

  void openSubCategoryBusiness(int lastIndex) {
    this.lastIndex = lastIndex;
    Get.put(DetailController());
    changeIndex(7);
  }

  // void openBusinessDetails(int lastIndex) {
  //   this.lastIndex = lastIndex;
  //   changeIndex(8);
  // }

  @override
  void onInit() {
    super.onInit();
    // homeCategoryList.add(HomeCategoryItems("Restaurants",
    //     "https://cdn-icons-png.flaticon.com/128/561/561611.png"));
    // homeCategoryList.add(HomeCategoryItems("Home Services",
    //     "https://cdn-icons-png.flaticon.com/128/619/619153.png"));
    // homeCategoryList.add(HomeCategoryItems("Tour & Travel",
    //     "https://cdn-icons-png.flaticon.com/128/4283/4283062.png"));
    // homeCategoryList.add(HomeCategoryItems("Hotel & Resorts",
    //     "https://cdn-icons-png.flaticon.com/128/1926/1926407.png"));
    // homeCategoryList.add(HomeCategoryItems(" Automobile",
    //     "https://cdn-icons-png.flaticon.com/512/3626/3626927.png"));
    // homeCategoryList.add(HomeCategoryItems("Beauty & Spa",
    //     "https://cdn-icons-png.flaticon.com/128/1005/1005763.png"));
    // homeCategoryList.add(HomeCategoryItems("Entertainment",
    //     "https://cdn-icons-png.flaticon.com/128/3163/3163478.png"));
    // homeCategoryList.add(HomeCategoryItems(
    //     "More", "https://cdn-icons-png.flaticon.com/128/10172/10172168.png"));
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
