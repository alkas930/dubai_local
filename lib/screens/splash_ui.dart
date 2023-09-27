import 'package:dubai_local/Constants.dart';
import 'package:dubai_local/models/all_categories_response_model.dart';
import 'package:dubai_local/models/top_home_response_model.dart';
import 'package:dubai_local/services/networking_services/api_call.dart';
import 'package:dubai_local/utils/localisations/SharedPrefKeys.dart';
import 'package:dubai_local/utils/localisations/images_paths.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SplashUI extends StatefulWidget {
  const SplashUI({Key? key}) : super(key: key);

  @override
  State<SplashUI> createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {
  List<AllCategoriesData> categoryList = [];
  List<TopHomeData> topList = [];

  init() async {
    await Future.wait<void>([
      CallAPI().getAllCategories().then((value) {
        setState(() {
          categoryList = value.data;
        });
      }),
      CallAPI().getHomeTop().then((value) {
        setState(() {
          topList = value.data;
        });
      }),
      Future.delayed(const Duration(seconds: 3)),
    ]);
    navigateToNextScreen();
  }

  navigateToNextScreen() {
    GetStorage storage = GetStorage();
    int loginState =
        storage.read(SharedPrefrencesKeys.IS_LOGGED_BY) ?? Constants.loggedOut;
    if (loginState != Constants.loggedOut) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.main, (Route<dynamic> route) => false,
          arguments: {
            "categoryList": categoryList,
            "topList": topList,
          });
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.main, (Route<dynamic> route) => false,
          arguments: {
            "categoryList": categoryList,
            "topList": topList,
          });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: height,
          width: width,
          child: Image.asset(
            ImagesPaths.splash_img,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
