// ignore_for_file: library_private_types_in_public_api

import 'package:dubai_local/controllers/home_controller.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/localisations/images_paths.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _webViewController;
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    // String url = Get.arguments??"https://dubailocal.ae";

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Column(
        children: [
          const HeaderWidget(isBackEnabled: true),
          Expanded(
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(ImagesPaths.img_bg),
            //     fit: BoxFit.fill,
            //   ),
            // ),
            child: WebView(
              backgroundColor: Colors.transparent,
              initialUrl: homeController.webViewURL,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (await _webViewController.canGoBack()) {
      _webViewController.goBack();
      return false;
    } else {
      homeController.changeIndex(homeController.lastIndex);
      return false;
    }
  }
}
