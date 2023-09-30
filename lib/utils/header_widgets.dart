import 'dart:io';

import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/bottomNav.dart';
import 'package:dubai_local/screens/home_ui.dart';
import 'package:dubai_local/utils/localisations/SharedPrefKeys.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../models/all_categories_response_model.dart';
import '../models/top_home_response_model.dart';
import '../utils/localisations/images_paths.dart';

class HeaderWidget extends StatefulWidget {
  final bool isBackEnabled;
  final Function(int index)? changeIndex;
  final Function() onBack;
  final Function() returnToHome;

  const HeaderWidget({
    Key? key,
    required this.isBackEnabled,
    required this.changeIndex,
    required this.onBack,
    required this.returnToHome,
  }) : super(key: key);

  @override
  _HeaderWidget createState() => _HeaderWidget();
}

class _HeaderWidget extends State<HeaderWidget> {
  final userImage = GetStorage().read(SharedPrefrencesKeys.USER_IMAGE);
  final userLoggedIn = GetStorage().read(SharedPrefrencesKeys.IS_LOGGED_BY);
  List<AllCategoriesData> categoryList = [];
  List<TopHomeData> topList = [];

  Widget UserIcon() {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return Text('');
    } else {
      return GestureDetector(
        onTap: () {
          if (userLoggedIn == Constants.facebookLogin ||
              userLoggedIn == Constants.googleLogin) {
            widget.changeIndex!(9);
          } else {
            Navigator.pushNamed(context, AppRoutes.loginSignUp, arguments: {
              "categoryList": categoryList,
              "topList": topList,
            });
          }
        },
        child: Container(
          width: Constants.iconSize,
          height: Constants.iconSize,
          child: userLoggedIn == Constants.guestLogin ||
                  userImage.toString().trim().isEmpty
              ? FittedBox(
                  fit: BoxFit.fill,
                  child: Icon(
                    Icons.account_circle_rounded,
                    color: Colors.grey.shade100,
                  ),
                )
              : ClipOval(
                  child: Image.network(
                    userImage.toString().trim(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      // return SizedBox.shrink();
                      return FittedBox(
                        fit: BoxFit.fill,
                        child: Icon(
                          Icons.account_circle_rounded,
                          color: Colors.grey.shade100,
                        ),
                      );
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    if (args["categoryList"] != null && args["categoryList"]?.isNotEmpty) {
      categoryList = List<AllCategoriesData>.from(args["categoryList"]);
    }
    if (args["topList"] != null && args["topList"]?.isNotEmpty) {
      topList = List<TopHomeData>.from(args["topList"]);
    }

    return Padding(
      padding: EdgeInsets.only(top: 32),
      child: Container(
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: Constants.iconSize,
                height: Constants.iconSize,
                child: widget.isBackEnabled
                    ? GestureDetector(
                        onTap: () {
                          // Navigator.pop(context);
                          widget.onBack();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      )
                    : null),
            GestureDetector(
                onTap: () {
                  widget.returnToHome();
                },
                child: Image.asset(ImagesPaths.app_logo_d, width: width * .40)),
            UserIcon(),
          ],
        ),
      ),
    );
  }
}
