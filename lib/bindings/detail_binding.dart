import 'package:get/get.dart';

import '../controllers/detail_controllers.dart';

class DetailBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(DetailController());
  }
}