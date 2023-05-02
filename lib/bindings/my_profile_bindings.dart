import 'package:dubai_local/controllers/my_profile_controllers.dart';
import 'package:get/get.dart';

class MyProfileBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(MyProfileControllers());
  }
}