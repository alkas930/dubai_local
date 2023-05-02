import 'package:dubai_local/models/SubCategoryBusinessResponseModel.dart';
import 'package:dubai_local/models/all_categories_response_model.dart';
import 'package:dubai_local/models/business_details_response_model.dart';
import 'package:dubai_local/models/sub_categories_response_model.dart';
import 'package:dubai_local/models/top_home_response_model.dart';

import '../../utils/localisations/custom_widgets.dart';
import 'api_manager.dart';
import 'endpoints.dart';

class CallAPI {
  Future<AllCategoriesResponseModel> getAllCategories() async {
    AllCategoriesResponseModel result = AllCategoriesResponseModel(data: []);

    try {
      String endPoint = Endpoints.epAllCategories;

      var json = await APIManager().getAllCall(endPoint: endPoint);

      AllCategoriesResponseModel responseModel =
          AllCategoriesResponseModel.fromJson(json);

      printData(json.toString());
      if (responseModel.status == 200) {
        printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
        result = responseModel;
        return result;
      } else {
        result = responseModel;
        return result;
      }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

  Future<TopHomeResponseModel> getHomeTop() async {
    TopHomeResponseModel result = TopHomeResponseModel(data: []);

    try {
      String endPoint = Endpoints.epTopHome;

      var json = await APIManager().getAllCall(endPoint: endPoint);

      TopHomeResponseModel responseModel = TopHomeResponseModel.fromJson(json);

      printData(json.toString());
      if (responseModel.status == 200) {
        printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
        result = responseModel;
        return result;
      } else {
        result = responseModel;
        return result;
      }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

  Future<SubCategoryResponseModel> getSubCategories(
      {required String slug}) async {
    SubCategoryResponseModel result =
        SubCategoryResponseModel(category: [], subCatData: []);

    try {
      String endPoint = "${Endpoints.epSubCategory}$slug";

      var json = await APIManager().getAllCall(endPoint: endPoint);

      SubCategoryResponseModel responseModel =
          SubCategoryResponseModel.fromJson(json);

      printData(json.toString());
      // if (responseModel == 200) {
      printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
      result = responseModel;
      return result;
      // } else {
      //   result = responseModel;
      //   return result;
      // }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

  Future<SubCategoryBusinessResponseModel> getSubCategoriesBusiness(
      {required String slug}) async {
    SubCategoryBusinessResponseModel result =
        SubCategoryBusinessResponseModel();

    try {
      String endPoint = "${Endpoints.epSubCategoryBusiness}$slug";

      var json = await APIManager().getAllCall(endPoint: endPoint);

      SubCategoryBusinessResponseModel responseModel =
          SubCategoryBusinessResponseModel.fromJson(json);

      printData(json.toString());
      // if (responseModel == 200) {
      printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
      result = responseModel;
      return result;
      // } else {
      //   result = responseModel;
      //   return result;
      // }
    } on Exception catch (e) {
      printData(e.toString());
      return result;
    }
  }

  Future<BusinessDetailResponseModel> getBusinessDetail(
      {required String businessSlug}) async {
    BusinessDetailResponseModel result = BusinessDetailResponseModel();

    try {
      String endPoint = "${Endpoints.epBusinessDetails}$businessSlug";

      var json = await APIManager().getAllCall(endPoint: endPoint);

      BusinessDetailResponseModel responseModel =
          BusinessDetailResponseModel.fromJson(json);

      printData(json.toString());
      // if (responseModel == 200) {
      printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
      result = responseModel;
      return result;
      // } else {
      //   result = responseModel;
      //   return result;
      // }
    } on Exception catch (e) {
      printData("DATETIME EXCEPTION: " + e.toString());
      return result;
    }
  }
}
