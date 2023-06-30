import 'dart:developer';

import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/services/networking_services/api_manager.dart';
import 'package:dubai_local/utils/localisations/SharedPrefKeys.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:dubai_local/utils/localisations/images_paths.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/networking_services/api_call.dart';

class LoginSignUpUI extends StatelessWidget {
  const LoginSignUpUI({Key? key}) : super(key: key);

  void saveUser(GoogleSignInAccount? data, BuildContext context, args,
      GetStorage storage) {
    CallAPI().createUser(body: {
      "userid": data?.id ?? "",
      "social_media_type": "gmail",
      "username": data?.displayName ?? "",
      "emailid": data?.email ?? "",
      "phonenumber": "",
      "password": "",
    }).then((value) {
      if (value["data"] != null) {
        storage.write(SharedPrefrencesKeys.IS_LOGGED_BY, Constants.googleLogin);
        storage.write(SharedPrefrencesKeys.USER_NAME, data!.displayName ?? "");
        storage.write(SharedPrefrencesKeys.USER_ID, data.id ?? "");
        storage.write(SharedPrefrencesKeys.USER_IMAGE, data.photoUrl ?? "");
        storage.write(SharedPrefrencesKeys.USER_EMAIL, data.email ?? "");
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.main, (Route<dynamic> route) => false,
            arguments: args);
      }
    }).catchError((onError) {});
  }

  @override
  Widget build(BuildContext context) {
    final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GetStorage storage = GetStorage();
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(ImagesPaths.img_bg),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 105,
                ),
                child: Image.asset(
                  ImagesPaths.app_logo_d,
                  width: width * 0.5,
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: 55),
              //   child: facebookLoginButton(
              //       title: "Facebook",
              //       imagePath: ImagesPaths.ic_facebook,
              //       onTap: () {
              //         facebookLoginHandler(context: context, storage: storage);
              //       },
              //       width: width),
              // ),
              Container(
                margin: const EdgeInsets.only(top: 35),
                child: googleLogin(
                    title: "Google",
                    imagePath: ImagesPaths.ic_google,
                    onTap: () {
                      googleSignIn.signIn().then((value) {
                        saveUser(value, context, args, storage);
                      }).onError((error, stackTrace) {
                        log(error.toString());
                        log(stackTrace.toString());
                      });
                    },
                    width: width),
              ),
              Container(
                margin: EdgeInsets.only(top: 85),
                child: InkButton(
                    borderRadius: 5,
                    width: width * .7,
                    backGroundColor: Colors.grey.shade300,
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Text(
                        "CONTINUE WITHOUT LOGIN",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    onTap: () {
                      storage.write(SharedPrefrencesKeys.IS_LOGGED_BY,
                          Constants.loggedOut);
                      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main,
                          (Route<dynamic> route) => false,
                          arguments: args);
                    }),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    "By signing in, you are agreeing to our Terms & Conditions and Privacy Policy.",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget googleLogin(
      {required String title,
      required String imagePath,
      required Function onTap,
      required double width}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: width * .75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    imagePath,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Login with $title",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget facebookLoginButton(
      {required String title,
      required String imagePath,
      required Function onTap,
      required double width}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: width * .75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xff1877F2),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    imagePath,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Login with $title",
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void facebookLoginHandler(
      {required BuildContext context, required GetStorage storage}) async {
    try {
      LoginResult result =
          await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        Map<String, dynamic> userData = await FacebookAuth.i.getUserData();
        storage.write(
            SharedPrefrencesKeys.IS_LOGGED_BY, Constants.facebookLogin);
      }
    } catch (error) {
      if (kDebugMode) {}
    }
  }
}
