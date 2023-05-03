import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dubai_local/services/networking_services/endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../utils/localisations/SharedPrefKeys.dart';
import '../../utils/localisations/app_strings.dart';
import 'custom_exception.dart';

class APIManager {
  GetStorage storage = GetStorage();

  var headers = {'api-key': 'ad238d3e391635dcf33a82a0e0275789'};

  Future<dynamic> getAllCall({required String endPoint}) async {
    String newBaseURL = Endpoints.BASE_URL + Endpoints.API_ENDPOINT;

    printData("NEW BASE URL ${newBaseURL.toString()}");

    Uri urlForPost = Uri.parse("$newBaseURL$endPoint");
    var responseJson = {};

    printData("URL For Get is: $urlForPost");

    printData("HEADERS: $headers");
    try {
      final response = await http.get(urlForPost, headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAPICall(
      {required String endPoint, required var request}) async {
    String newBaseURL = storage.read(SharedPrefrencesKeys.BASE_URL_KEY);

    Uri urlForPost = Uri.parse("$newBaseURL$endPoint");

    printData("Calling API: $urlForPost");

    printData("Calling Request: $request");

    var responseJson = {};

    printData("HEADERS: $headers");

    try {
      final response = await http.post(urlForPost,
          headers: headers, body: jsonEncode(request));
      printData(response.body);
      responseJson = _response(response);
    } on SocketException {
      showSnackBar("", "Internet not available");
      throw FetchDataException('No Internet connection');
    } on Error catch (e) {
      printData('Error: $e');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    printData(response.statusCode);

    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 403:
        // showSnackBar(response.statusCode);
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        // showSnackBar(response.statusCode);
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }

  void showSnackBar(statusCode, message) {
    // Get.snackbar(
    //   AppStrings.appName,
    //   "${message ?? "Something went wrong Status Code"} : $statusCode",
    //   snackPosition: SnackPosition.TOP,
    // );
  }

  void printData(responseData) {
    if (kDebugMode) {
      print(responseData);
    }
  }
}
