import 'package:get/get.dart';

import '../controllers/login_signup_controllers.dart';

class LoginSignUpBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(LoginSignUpControllers());
  }
}