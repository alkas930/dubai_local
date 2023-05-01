import 'package:dubai_local/utils/routes/app_pages.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoreController extends SuperController {
  void moreOnWebView() {
    Get.toNamed(AppRoutes.webview);
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
