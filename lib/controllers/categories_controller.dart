import 'package:get/get.dart';

import '../models/all_categories_response_model.dart';
import '../models/top_home_response_model.dart';
import '../services/networking_services/api_call.dart';
import '../utils/localisations/custom_widgets.dart';

class CategoriesController extends SuperController {
  List<AllCategoriesData> categoryList = [];
  List<TopHomeData> topList = [];
  String updateListKey = "updateListKey";
  String updateTopKey = "updateTop";

  @override
  void onInit() {
    super.onInit();
    CallAPI().getAllCategories().then((value) {
      categoryList = value.data;
      update([updateListKey]);
    });

    CallAPI().getHomeTop().then((value) {
      topList = value.data;
      update([updateTopKey]);
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
