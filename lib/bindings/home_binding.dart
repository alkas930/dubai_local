import 'package:dubai_local/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../controllers/categories_controller.dart';
import '../controllers/main_home_controller.dart';
import '../controllers/more_controller.dart';
import '../controllers/search_controller.dart';

class HomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(MainHomeController());
    Get.put(SearchController());
    Get.put(CategoriesController());
    Get.put(MoreController());
  }
}