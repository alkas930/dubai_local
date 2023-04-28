import 'package:dubai_local/controllers/more_controller.dart';
import 'package:get/get.dart';

class MoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MoreController());
  }
}
