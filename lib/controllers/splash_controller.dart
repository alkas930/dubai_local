import 'package:dubai_local/utils/localisations/SharedPrefKeys.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/routes/app_routes.dart';

class SplashController extends SuperController {
  @override
  void onInit() {
    GetStorage storage = GetStorage();

    String data= storage.read(SharedPrefrencesKeys.IS_LOGGED_BY)??"";
    printData("$data");
    Future.delayed(const Duration(seconds: 3), () {


     if(data=="GUEST"||data=="GOOGLE"||data=="FACEBOOK"){
       Get.offAllNamed(AppRoutes.mainHome);
     } else{
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
