import 'dart:convert';

import 'package:dubai_local/models/SearchModel.dart';
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

      if (responseModel.status == 200) {
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

      if (responseModel.status == 200) {
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

      // if (responseModel == 200) {
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

      // if (responseModel == 200) {
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
      {bool isSearch = false, required String businessSlug}) async {
    BusinessDetailResponseModel result = BusinessDetailResponseModel();

    try {
      String endPoint =
          "${isSearch ? Endpoints.epFindBusinessDetails : Endpoints.epBusinessDetails}$businessSlug";

      var json;
      if (isSearch) {
        json = await APIManager().postAPICall(endPoint: endPoint, request: {});
      } else {
        json = await APIManager().getAllCall(endPoint: endPoint);
      }
      BusinessDetailResponseModel responseModel =
          BusinessDetailResponseModel.fromJson(json);

      // if (responseModel == 200) {
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

  Future<Map?> sendEnquiry({required Map body}) async {
    // BusinessDetailResponseModel result = BusinessDetailResponseModel();

    try {
      String endPoint = "${Endpoints.epContactUs}";

      var result =
          await APIManager().postAPICall(endPoint: endPoint, request: body);
      // if (responseModel == 200) {
      return result;
      // } else {
      //   result = responseModel;
      //   return result;
      // }
    } on Exception catch (e) {
      printData(e.toString());
      return null;
    }
  }

  Future<Map?> claimBusiness({required Map body}) async {
    // BusinessDetailResponseModel result = BusinessDetailResponseModel();

    try {
      String endPoint = "${Endpoints.epClaimBusiness}";

      var result =
          await APIManager().postAPICall(endPoint: endPoint, request: body);
      // if (responseModel == 200) {
      return result;
      // } else {
      //   result = responseModel;
      //   return result;
      // }
    } on Exception catch (e) {
      printData(e.toString());
      return null;
    }
  }

  Future<SearchModel> search({required Map body}) async {
    try {
      String endPoint = "${Endpoints.epSearch}";

      var result =
          await APIManager().postAPICall(endPoint: endPoint, request: body);
      SearchModel responseModel = SearchModel.fromJson(result);
      // if (responseModel == 200) {
      return responseModel;
      // } else {
      //   result = responseModel;
      //   return result;
      // }
    } on Exception catch (e) {
      printData(e.toString());
      return new SearchModel();
    }
  }

  Future<SearchModel> searchKeywords({required String keyword}) async {
    try {
      String endPoint = "${Endpoints.epKeyword}${keyword}";

      var result = await APIManager().getAllCall(endPoint: endPoint);
      SearchModel responseModel = SearchModel.fromJson(result);
      // if (responseModel == 200) {
      return responseModel;
      // } else {
      //   result = responseModel;
      //   return result;
      // }
    } on Exception catch (e) {
      printData(e.toString());
      return new SearchModel();
    }
  }

  Future<Map> createUser({required Map body}) async {
    try {
      String endPoint = "${Endpoints.createUser}";

      var result =
          await APIManager().postAPICall(endPoint: endPoint, request: body);
      // SearchModel responseModel = SearchModel.fromJson(result);
      // if (responseModel == 200) {
      return result;
      // } else {
      //   result = responseModel;
      //   return result;
      // }
    } on Exception catch (e) {
      printData(e.toString());
      return new Map();
    }
  }

  Future<Map> deleteUser({required Map body}) async {
    try {
      String endPoint = "${Endpoints.deleteUser}";

      var result =
          await APIManager().postAPICall(endPoint: endPoint, request: body);
      // SearchModel responseModel = SearchModel.fromJson(result);
      // if (responseModel == 200) {
      return result;
      // } else {
      //   result = responseModel;
      //   return result;
      // }
    } on Exception catch (e) {
      printData(e.toString());
      return new Map();
    }
  }
}
