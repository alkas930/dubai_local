import 'package:dubai_local/controllers/home_controller.dart';
import 'package:dubai_local/models/sub_categories_response_model.dart';
import 'package:get/get.dart';

import '../services/networking_services/api_call.dart';
import '../utils/localisations/custom_widgets.dart';

class SubCategoryController extends SuperController {
  List<SubcatData> subCategoryList = [];
  String updateListKey = "updateListKey";

  @override
  void onInit() {
    super.onInit();
  }

  void callAPI() {
    HomeController homeController = Get.find();
    CallAPI().getSubCategories(slug: homeController.subCatSlug).then((value) {
      subCategoryList = value.subCatData;
      update([updateListKey]);
      printData("DATA ${value.toJson().toString()}");
    });
  }

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
