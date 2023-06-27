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

  const MyProfile({
    Key? key,
    required this.changeIndex,
    required this.setArgs,
    required this.onBack,
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
    }).catchError((onError) {});
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
          ),
          const Text("My Profile",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w400)),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName ?? "",
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Edit Profile",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textColorGrey,
                                  decoration: TextDecoration.underline),
                            )
                          ],
                        )
                      ],
                    ),
                    profileItems(
                        title: "My Profile",
                        icon: ImagesPaths.ic_star,
                        width: width),
                    const Divider(),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showAlertDialog(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            margin: const EdgeInsets.only(right: 8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.greenTheme),
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            deleteUser(context, storage);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            margin: const EdgeInsets.only(left: 8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(Constants.themeColorRed)),
                            child: const Text(
                              "Delete Account",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
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
