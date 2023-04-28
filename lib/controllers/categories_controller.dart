import 'package:get/get.dart';

import '../models/all_categories_response_model.dart';
import '../services/networking_services/api_call.dart';
import '../utils/localisations/custom_widgets.dart';

class CategoriesController extends SuperController {
  List<AllCategoriesData> categoryList = [];
  String updateListKey = "updateListKey";
  @override
  void onInit() {
    CallAPI().getAllCategories().then((value) {
      categoryList = value.data;
      update([updateListKey]);
      printData("DATA ${value.toJson().toString()}");
    });
    super.onInit();
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
