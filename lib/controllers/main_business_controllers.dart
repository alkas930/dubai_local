import 'dart:convert';

import 'package:dubai_local/models/business_details_response_model.dart';
import 'package:dubai_local/services/networking_services/api_call.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MainBusinessControllers extends SuperController {
  RxBool isVisible = false.obs;
  Rx<BusinessDetailResponseModel> businessDetail =
      BusinessDetailResponseModel().obs;

  changeVisibility() {
    isVisible.value = !isVisible.value;
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

  void onTapSendEnquiry() {}

  void onTapSendToFriend() {}

  @override
  void onInit() {
    callAPI("businessSlug");
    super.onInit();
  }

  void callAPI(String businessSlug) {
    CallAPI().getBusinessDetail(businessSlug: businessSlug).then((value) {
      businessDetail.value = value;
    });
  }
}
