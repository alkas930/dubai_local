import 'package:dubai_local/controllers/home_controller.dart';
import 'package:dubai_local/controllers/search_controller.dart';
import 'package:get/get.dart';

class SearchBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(SearchController());
  }
}