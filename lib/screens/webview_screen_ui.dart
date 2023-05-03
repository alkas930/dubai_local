// ignore_for_file: library_private_types_in_public_api

import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/services/networking_services/endpoints.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/localisations/images_paths.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Column(
        children: [
          const HeaderWidget(isBackEnabled: true),
          Expanded(
              child: Stack(
            children: [
              isLoading
                  ? Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(Constants.themeColorRed),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              WebView(
                backgroundColor: Colors.transparent,
                initialUrl: args?["url"] != null && args?["url"]?.isNotEmpty
                    ? args["url"]
                    : Endpoints.BASE_URL,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
                // onWebViewCreated: (WebViewController webViewController) {
                // },
              ),
            ],
          )),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context);
    return false;
  }
}
