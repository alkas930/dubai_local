import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/utils/localisations/SharedPrefKeys.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/routes/app_routes.dart';

class SplashController extends SuperController {
  @override
  void onInit() {
    GetStorage storage = GetStorage();

    int loginState =
        storage.read(SharedPrefrencesKeys.IS_LOGGED_BY) ?? Constants.LOGGED_OUT;
    Future.delayed(const Duration(seconds: 3), () {
      if (loginState != Constants.LOGGED_OUT) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.loginSignUp);
      }
    });
    super.onInit();
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
