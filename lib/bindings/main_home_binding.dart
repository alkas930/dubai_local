import 'package:dubai_local/controllers/categories_controller.dart';
import 'package:dubai_local/controllers/search_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/main_home_controller.dart';
import '../controllers/more_controller.dart';

class MainHomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(MainHomeController());
    Get.put(HomeController());
    Get.put(SearchController());
    Get.put(CategoriesController());
    Get.put(MoreController());
  }
}