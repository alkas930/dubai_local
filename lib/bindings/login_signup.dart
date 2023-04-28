import 'package:dubai_local/services/networking_services/api_manager.dart';
import 'package:dubai_local/utils/localisations/SharedPrefKeys.dart';
import 'package:dubai_local/utils/localisations/custom_widgets.dart';
import 'package:dubai_local/utils/localisations/images_paths.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginSignUpUI extends StatelessWidget {
  const LoginSignUpUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagesPaths.img_bg),
                fit: BoxFit.cover,
              )),
          child: Column(
            children: [
              Image.asset(ImagesPaths.app_logo_d)
                  .w(Get.width * .5)
                  .marginOnly(top: 105),
              facebookLogin(
                  title: "Facebook",
                  imagePath: ImagesPaths.ic_facebook,
                  onTap: () {
                    facebookLoginF(context: context);
                  }).marginOnly(top: 55),
              googleLogin(
                  title: "Google",
                  imagePath: ImagesPaths.ic_google,
                  onTap: () {
                    googleSignIn.signIn().then((value) {
                      GetStorage storage = GetStorage();
                      storage.write(SharedPrefrencesKeys.IS_LOGGED_BY, "GOOGLE");
                      storage.write(SharedPrefrencesKeys.USER_NAME, value!.displayName??"");
                      storage.write(SharedPrefrencesKeys.USER_ID, value.id??"");
                      storage.write(SharedPrefrencesKeys.USER_IMAGE, value.photoUrl??"");
                      storage.write(SharedPrefrencesKeys.USER_EMAIL, value.email??"");
                      printData("${value}");
                    }).onError((error, stackTrace) {
                    });
                  }).marginOnly(top: 35),
              InkButton(
                  borderRadius: 5,
                  width: Get.width * .7,
                  backGroundColor: Colors.grey.shade300,
                  height: 40,
                  child: "CONTINUE WITHOUT LOGIN"
                      .text
                      .color(Colors.grey.shade700)
                      .caption(context)
                      .fontFamily("Poppins")
                      .make()
                      .px(25)
                      .py(10),
                  onTap: () {

                    GetStorage storage = GetStorage();
                    storage.write(SharedPrefrencesKeys.IS_LOGGED_BY, "GUEST");
                    Get.offNamed(AppRoutes.mainHome);
                  }).marginOnly(top: 85),
              "By signing in, you are agreeing to our Terms & Conditions and Privacy Policy."
                  .text
                  .white
                  .size(14)
                  .fontFamily("Poppins")
                  .center
                  .semiBold
                  .make()
                  .marginOnly(top: 30)
                  .px(15)
            ],
          ),
        ),
      ),
    );
  }

  Widget googleLogin({required String title,
    required String imagePath,
    required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: Get.width * .75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  imagePath,
                ),
              ).p(8),
            ),
            "Login with $title"
                .text
                .white
                .size(18)
                .fontFamily("Poppins")
                .make()
                .pOnly(left: 15)
          ],
        ),
      ),
    );
  }

  Widget facebookLogin({required String title,
    required String imagePath,
    required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: Get.width * .75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xff1877F2),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  imagePath,
                ),
              ).p(5),
            ),
            "Login with $title"
                .text
                .white
                .size(18)
                .fontFamily("Poppins")
                .make()
                .pOnly(left: 15)
          ],
        ),
      ),
    );
  }

  void facebookLoginF({required BuildContext context}) async {
    try {
      LoginResult result =
      await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {

        Map<String, dynamic> userData = await FacebookAuth.i.getUserData();
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
}
