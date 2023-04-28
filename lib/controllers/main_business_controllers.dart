import 'package:get/get.dart';

class MainBusinessControllers extends SuperController {
  RxBool isVisible = false.obs;

  changeVisibility(){
    isVisible.value=!isVisible.value;
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
}
