import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/utils/localisations/SharedPrefKeys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/all_categories_response_model.dart';
import '../models/top_home_response_model.dart';
import '../services/networking_services/api_call.dart';
import '../utils/routes/app_routes.dart';

class SplashController extends SuperController {
  List<AllCategoriesData> categoryList = [];
  List<TopHomeData> topList = [];
  String updateListKey = "updateListKey";
  String updateTopKey = "updateTop";

  @override
  void onInit() {
    super.onInit();
    GetStorage storage = GetStorage();
    CallAPI().getAllCategories().then((value) {
      categoryList = value.data;
      update([updateListKey]);
    });

    CallAPI().getHomeTop().then((value) {
      topList = value.data;
      update([updateTopKey]);
    });
    int loginState =
        storage.read(SharedPrefrencesKeys.IS_LOGGED_BY) ?? Constants.loggedOut;
    Future.delayed(const Duration(seconds: 3), () {
      if (loginState != Constants.loggedOut) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.loginSignUp);
      }
    });
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
