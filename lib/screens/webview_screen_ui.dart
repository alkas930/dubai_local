// ignore_for_file: library_private_types_in_public_api

import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/services/networking_services/endpoints.dart';
import 'package:dubai_local/utils/header_widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/localisations/images_paths.dart';

class WebViewScreen extends StatefulWidget {
  final Function(int index)? changeIndex;
  final Function(Map args)? setArgs;
  final Function() onBack;
  final Map args;

  const WebViewScreen(
      {Key? key,
      required this.changeIndex,
      required this.setArgs,
      required this.onBack,
      required this.args})
      : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    // final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Column(
        children: [
          HeaderWidget(
            isBackEnabled: true,
            changeIndex: widget.changeIndex,
            onBack: widget.onBack,
          ),
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
                        margin: const EdgeInsets.only(top: 8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Color(Constants.themeColorRed),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: WebView(
                  navigationDelegate: (NavigationRequest request) {
                    if (request.url.contains("mailto:")) {
                      launchUrl(Uri.parse(request.url));
                      return NavigationDecision.prevent;
                    } else if (request.url.contains("tel:")) {
                      launchUrl(Uri.parse(request.url));
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  },
                  backgroundColor: Colors.transparent,
                  initialUrl: widget.args?["url"] != null &&
                          widget.args?["url"]?.isNotEmpty
                      ? widget.args["url"]
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
              ),
            ],
          )),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    // Navigator.pop(context);
    widget.onBack();
    return false;
  }
}
