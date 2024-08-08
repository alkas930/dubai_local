import 'dart:developer';

import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/utils/localisations/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../services/networking_services/api_call.dart';
import '../utils/header_widgets.dart';
import '../utils/localisations/SharedPrefKeys.dart';
import '../utils/localisations/images_paths.dart';
import '../utils/routes/app_routes.dart';

class MyProfile extends StatelessWidget {
  final Function(int index)? changeIndex;
  final Function(Map args)? setArgs;
  final Function() onBack;
  final Map args;
  final Function() returnToHome;

  const MyProfile({
    Key? key,
    required this.changeIndex,
    required this.setArgs,
    required this.onBack,
    required this.returnToHome,
    required this.args,
  }) : super(key: key);

  Future<bool> _onWillPop() async {
    // Navigator.pop(context);
    onBack();
    return false;
  }

  void deleteUser(BuildContext context, GetStorage storage) {
    String id = storage.read(SharedPrefrencesKeys.USER_EMAIL);
    CallAPI().deleteUser(body: {
      "userid": id ?? "",
    }).then((value) {
      if (value["data"] != null) {
        storage.remove(SharedPrefrencesKeys.IS_LOGGED_BY);
        storage.remove(SharedPrefrencesKeys.USER_NAME);
        storage.remove(SharedPrefrencesKeys.USER_ID);
        storage.remove(SharedPrefrencesKeys.USER_IMAGE);
        storage.remove(SharedPrefrencesKeys.USER_EMAIL);
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.splash, (Route<dynamic> route) => false);
      }
    }).catchError((onError) {
      log(onError);
    });
  }

  void logOut(BuildContext context, GetStorage storage) {
    storage.remove(SharedPrefrencesKeys.IS_LOGGED_BY);
    storage.remove(SharedPrefrencesKeys.USER_NAME);
    storage.remove(SharedPrefrencesKeys.USER_ID);
    storage.remove(SharedPrefrencesKeys.USER_IMAGE);
    storage.remove(SharedPrefrencesKeys.USER_EMAIL);
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.splash, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final GetStorage storage = GetStorage();
    final userImage = storage.read(SharedPrefrencesKeys.USER_IMAGE);
    final userName = storage.read(SharedPrefrencesKeys.USER_NAME);
    final userLoggedIn = storage.read(SharedPrefrencesKeys.IS_LOGGED_BY);

    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: const Text("Cancel"),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        },
      );
      Widget continueButton = TextButton(
        child: const Text("Continue"),
        onPressed: () {
          logOut(context, storage);
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text("Logout"),
        content: const Text("Do you want to logout ?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Column(
        children: [
          HeaderWidget(
            isBackEnabled: true,
            changeIndex: changeIndex,
            onBack: onBack,
            returnToHome: returnToHome,
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 24,
            ),
            child: Text(
              "My Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
            ),
          ),
          Expanded(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    color: Color(0xffF7F7F7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
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
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userName ?? "",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    changeIndex!(10);
                                  },
                                  child: Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.greenTheme,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    deleteUser(context, storage);
                                  },
                                  child: const Text(
                                    "Delete Account",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff818181)),
                                  ),
                                ),
                                const Text(" | ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4c4c4c))),
                                GestureDetector(
                                  onTap: () {
                                    showAlertDialog(context);
                                  },
                                  child: const Text(
                                    "Logout",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4c4c4c)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  // profileItems(
                  //     title: "My Profile",
                  //     icon: ImagesPaths.ic_star,
                  //     width: width),
                  // const Divider(),
                  // profileItems(
                  //     title: "My Listings",
                  //     icon: ImagesPaths.ic_listings,
                  //     width: width),
                  // const Divider(),
                  // profileItems(
                  //     title: "Favourites",
                  //     icon: ImagesPaths.ic_star,
                  //     width: width),
                  // const Divider(),
                  // profileItems(
                  //     title: "My Membership",
                  //     icon: ImagesPaths.ic_star,
                  //     width: width),
                  // const Divider(),
                  // profileItems(
                  //     title: "Payments",
                  //     icon: ImagesPaths.ic_payment,
                  //     width: width),
                  // const Divider(),
                  // profileItems(
                  //     title: "My Documents",
                  //     icon: ImagesPaths.ic_document,
                  //     width: width),
                  // const SizedBox(
                  //   height: 40,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileItems(
      {required String title, required String icon, required double width}) {
    return Padding(
      // ignore: prefer_const_constructors
      padding: EdgeInsets.only(top: 8),
      child: SizedBox(
        width: width * .94,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 18,
                  height: 18,
                  child: Image.asset(
                    icon,
                    width: 18,
                    height: 18,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14),
                )
              ],
            ),
            SizedBox(
              width: 18,
              height: 18,
              child: Image.asset(ImagesPaths.ic_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
