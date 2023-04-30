import 'package:dubai_local/models/SubCategoryBusinessResponseModel.dart';
import 'package:dubai_local/models/all_categories_response_model.dart';
import 'package:dubai_local/models/sub_categories_response_model.dart';
import 'package:dubai_local/models/top_home_response_model.dart';

import '../../utils/localisations/custom_widgets.dart';
import 'api_manager.dart';
import 'endpoints.dart';

class CallAPI {
  //API BUSINESS ID
//   Future<BusinessIDResponseModel> validateBusiness(
//       {required var loginRequestModel}) async {
//     BusinessIDResponseModel result = BusinessIDResponseModel();
//
//     try {
//       String endPoint = Endpoints.epBusinessLogin;
//
//       var json = await APIManager()
//           .postAPICallBusiness(endPoint: endPoint, param: loginRequestModel);
//
//       BusinessIDResponseModel loginModel =
//           BusinessIDResponseModel.fromJson(json);
//       if (loginModel.status == true) {
//         result = loginModel;
//         printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
//         return result;
//       } else {
//         result = loginModel;
//         return result;
//       }
//     } on Exception catch (e) {
//       printData(e.toString());
//       return result;
//     }
//   }
//
// //   Driver Get OTP
//   Future<SendOTPResponseModel> sendOTP({required var phoneRequestModel}) async {
//     SendOTPResponseModel result = SendOTPResponseModel();
//
//     try {
//       String endPoint = Endpoints.epDriverOTP;
//
//       var json = await APIManager()
//           .postAPICall(endPoint: endPoint, request: phoneRequestModel);
//
//       SendOTPResponseModel responseModel = SendOTPResponseModel.fromJson(json);
//       if (responseModel.status == true) {
//         result = responseModel;
//         printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
//         return result;
//       } else {
//         result = responseModel;
//         return result;
//       }
//     } on Exception catch (e) {
//       printData(e.toString());
//       return result;
//     }
//   }
//
// //   Driver Resend OTP
//   Future<ResendOTPResponseModel> resendOTP(
//       {required var phoneRequestModel}) async {
//     ResendOTPResponseModel result = ResendOTPResponseModel();
//
//     try {
//       String endPoint = Endpoints.epDriverResendOTP;
//
//       var json = await APIManager()
//           .postAPICall(endPoint: endPoint, request: phoneRequestModel);
//
//       ResendOTPResponseModel responseModel =
//           ResendOTPResponseModel.fromJson(json);
//       if (responseModel.status == true) {
//         result = responseModel;
//         printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
//         return result;
//       } else {
//         result = responseModel;
//         return result;
//       }
//     } on Exception catch (e) {
//       printData(e.toString());
//       return result;
//     }
//   }
//
// //   Driver LOGIN
//   Future<DriverLoginResponseModel> loginDriver(
//       {required var loginRequestModel}) async {
//     DriverLoginResponseModel result = DriverLoginResponseModel();
//     try {
//       String endPoint = Endpoints.epDriverLogin;
//       var json = await APIManager()
//           .postAPICall(endPoint: endPoint, request: loginRequestModel);
//
//       DriverLoginResponseModel responseModel =
//           DriverLoginResponseModel.fromJson(json);
//       if (responseModel.status == true) {
//         result = responseModel;
//         printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
//         return result;
//       } else {
//         result = responseModel;
//         return result;
//       }
//     } on Exception catch (e) {
//       printData(e.toString());
//       return result;
//     }
//   }
//
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

//
//   Future<RouteListResponseModel> getDriverRouteList(request) async {
//     RouteListResponseModel result = RouteListResponseModel(data: []);
//
//     try {
//       String endPoint = Endpoints.epDriverRouteList;
//
//       var json =
//           await APIManager().postAPICall(endPoint: endPoint, request: request);
//
//       RouteListResponseModel responseModel =
//           RouteListResponseModel.fromJson(json);
//       if (responseModel.status == true) {
//         printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
//         result = responseModel;
//         return result;
//       } else {
//         result = responseModel;
//         return result;
//       }
//     } on Exception catch (e) {
//       printData(e.toString());
//       return result;
//     }
//   }
//
//   Future<DriverStopsResponseModel> getDriverStopsList(request) async {
//     DriverStopsResponseModel result = DriverStopsResponseModel(data: []);
//
//     try {
//       String endPoint = Endpoints.epDriverStopList;
//
//       var json =
//           await APIManager().postAPICall(endPoint: endPoint, request: request);
//
//       DriverStopsResponseModel responseModel =
//           DriverStopsResponseModel.fromJson(json);
//       if (responseModel.status == true) {
//         printData("CALLING_ENDPOINT: $endPoint ,RESPONSE:  $json");
//         result = responseModel;
//         return result;
//       } else {
//         result = responseModel;
//         return result;
//       }
//     } on Exception catch (e) {
//       printData(e.toString());
//       return result;
//     }
//   }
//
//   Future<DriverStopDetailsResponseModel> driverStopDetails(request) async {
//     DriverStopDetailsResponseModel result = DriverStopDetailsResponseModel();
//
//     try {
//       String endPoint = Endpoints.epDriverStopDetails;
//       var json =
//           await APIManager().postAPICall(endPoint: endPoint, request: request);
//       DriverStopDetailsResponseModel responseModel =
//           DriverStopDetailsResponseModel.fromJson(json);
//       if (responseModel.status == true) {
//         printData("CALLING_ENDPOINT: $endPoint ,RESPONSE: $json");
//         result = responseModel;
//         return result;
//       } else {
//         result = responseModel;
//         return result;
//       }
//     } on Exception catch (e) {
//       printData(e.toString());
//       return result;
//     }
//   }
//
//   Future<UpdateTokenResponseModel> getUpdatedToken() async {
//     UpdateTokenResponseModel result = UpdateTokenResponseModel();
//     try {
//       printData("Token has been expired Hitting Refresh Token API");
//       String endPoint = Endpoints.epUpdateToken;
//       var json = await APIManager().updateToken(endPoint: endPoint);
//       UpdateTokenResponseModel responseModel =
//           UpdateTokenResponseModel.fromJson(json);
//       if (responseModel.status == true) {
//         printData("CALLING_ENDPOINT: $endPoint ,RESPONSE: $json");
//         result = responseModel;
//         return result;
//       } else {
//         result = responseModel;
//         return result;
//       }
//     } on Exception catch (e) {
//       printData(e.toString());
//       return result;
//     }
//   }
//
//   Future<DriverNotesResponseModel> addStopNote(request) async {
//     DriverNotesResponseModel result = DriverNotesResponseModel();
//
//     try {
//       String endPoint = Endpoints.epDriverNotes;
//       var json =
//           await APIManager().postAPICall(endPoint: endPoint, request: request);
//       DriverNotesResponseModel responseModel =
//           DriverNotesResponseModel.fromJson(json);
//       if (responseModel.status == true) {
//         printData("CALLING_ENDPOINT: $endPoint ,RESPONSE: $json");
//         result = responseModel;
//         return result;
//       } else {
//         result = responseModel;
//         return result;
//       }
//     } on Exception catch (e) {
//       printData(e.toString());
//       return result;
//     }
//   }
//
//   Future<DriverStopUpdateResponseModel> updateStopStatus(request) async {
//     DriverStopUpdateResponseModel result = DriverStopUpdateResponseModel();
//
//     try {
//       String endPoint = Endpoints.epDriverUpdateStop;
//       var json =
//           await APIManager().postAPICall(endPoint: endPoint, request: request);
//       DriverStopUpdateResponseModel responseModel =
//           DriverStopUpdateResponseModel.fromJson(json);
//       if (responseModel.status == true) {
//         printData("CALLING_ENDPOINT: $endPoint ,RESPONSE: $json");
//         result = responseModel;
//         return result;
//       } else {
//         result = responseModel;
//         return result;
//       }
//     } on Exception catch (e) {
//       printData(e.toString());
//       return result;
//     }
//   }
//
//   Future<StartRouteResponseModel> startRoute(request) async {
//     StartRouteResponseModel result = StartRouteResponseModel();
//
//     try {
//       String endPoint = Endpoints.epStartRoute;
//       var json =
//           await APIManager().postAPICall(endPoint: endPoint, request: request);
//       StartRouteResponseModel responseModel =
//           StartRouteResponseModel.fromJson(json);
//       if (responseModel.status == true) {
//         printData("CALLING_ENDPOINT: $endPoint ,RESPONSE: $json");
//         result = responseModel;
//         return result;
//       } else {
//         result = responseModel;
//         return result;
//       }
//     } on Exception catch (e) {
//       printData(e.toString());
//       return result;
//     }
//   }
//
//   Future<CompleteRouteResponseModel> completeRoute(request) async {
//     CompleteRouteResponseModel result = CompleteRouteResponseModel();
//
//     try {
//       String endPoint = Endpoints.epCompleteRoute;
//       var json =
//           await APIManager().postAPICall(endPoint: endPoint, request: request);
//       CompleteRouteResponseModel responseModel =
//           CompleteRouteResponseModel.fromJson(json);
//       if (responseModel.status == true) {
//         printData("CALLING_ENDPOINT: $endPoint ,RESPONSE: $json");
//         result = responseModel;
//         return result;
//       } else {
//         result = responseModel;
//         return result;
//       }
//     } on Exception catch (e) {
//       printData(e.toString());
//       return result;
//     }
//   }
}
