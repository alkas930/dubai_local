// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class Endpoints {
  static String BASE_URL = "https://dubailocal.ae/";
  static String API_ENDPOINT = "api/";
  static String ExploreDubai = "https://dubailocal.ae/dubai-explore";
  static String ThingsToDo = "https://dubailocal.ae/things-to-do-in-dubai";
  static String Blog = "https://blog.dubailocal.ae/";
  static String UsefulNumbers = "https://dubailocal.ae/useful-numbers";

  static const String epSubCategoryBusiness = "businesses/";
  static const String epSubCategory = "category/";
  static const String epBusinessDetails = "business/";
  static const String epFindBusinessDetails = "find-business/";
  static const String epClaimBusiness = "claim-business";
  static const String epContactUs = "contact-us";
  static const String epAllCategories = "category";
  static const String epTopHome = "top-home";
  static const String epKeywords = "keywords";
  static const String epSearch = "search-v2";
  static const String epKeyword = "keyword?query=";
  static const String createUser = "create-user";
  static const String deleteUser = "delete-user";

  GetStorage storage = GetStorage();

  void printData(object) {
    if (kDebugMode) {
      print(object);
    }
  }
}
