import 'package:dubai_local/models/SubCategoryBusinessResponseModel.dart';
import 'package:dubai_local/services/networking_services/api_call.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';

import 'home_controller.dart';

class DetailController extends SuperController {
  // PlaceDetails product = Get.arguments;

  String updateListKey = "updateListKey";
  RxList<SubcatBusinessData> detailList = <SubcatBusinessData>[].obs;

  RxString placeName = "".obs;
  RxString category = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getData(String slug, String cat, String business) {
    detailList.clear();
    CallAPI().getSubCategoriesBusiness(slug: slug).then((value) {
      if (value.subcatBusinessData!.isNotEmpty) {
        detailList.addAllT(value.subcatBusinessData!);
      }
      category.value = cat;
      placeName.value = business;
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
