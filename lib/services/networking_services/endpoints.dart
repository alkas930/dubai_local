// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class Endpoints {
  static String BASE_URL = "https://dubailocal.ae/api/";

  static const String epSubCategoryBusiness = "businesses/";
  static const String epSubCategory = "category/";
  static const String epBusinessDetails = "businesses/";
  static const String epContactUs = "contact-us/";
  static const String epAllCategories = "category";
  static const String epTopHome = "top-home";
  static const String epKeywords = "keywords";
  static const String epSearch = "search";

  GetStorage storage = GetStorage();

  void printData(object) {
    if (kDebugMode) {
      print(object);
    }
  }
}
