import 'package:dubai_local/models/SubCategoryBusinessResponseModel.dart';
import 'package:dubai_local/services/networking_services/api_call.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import 'home_controller.dart';

class DetailController extends SuperController {
  // PlaceDetails product = Get.arguments;

  String updateListKey = "updateListKey";
  List<SubcatBusinessData> detailList = [];

  RxString placeName = "".obs;

  @override
  void onInit() {
    super.onInit();
    HomeController homeController = Get.find();
    CallAPI()
        .getSubCategoriesBusiness(slug: homeController.subCatBusinessSlug)
        .then((value) {
      detailList = value.subcatBusinessData ?? [];
      placeName.value = homeController.subBusiness;
      update([updateListKey]);
    }).onError((error, stackTrace) {
      print("$error $stackTrace");
      // ToastContext().init(Get.context!);
      // Toast.show("$error");
    });

  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}

class DetailItems {
  String? categoryName;
  String? categoryImage;

  DetailItems(this.categoryName, this.categoryImage);
}

class PlaceDetails {
  String? title;

  PlaceDetails(this.title);
}
