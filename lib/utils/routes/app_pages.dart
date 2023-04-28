import 'package:dubai_local/bindings/home_binding.dart';
import 'package:dubai_local/bindings/login_signup.dart';
import 'package:dubai_local/bindings/main_business_bindings.dart';
import 'package:dubai_local/bottomNav.dart';
import 'package:dubai_local/screens/categories_ui.dart';
import 'package:dubai_local/screens/detail_Ui.dart';
import 'package:dubai_local/screens/home_ui.dart';
import 'package:dubai_local/screens/more_ui.dart';
import 'package:dubai_local/screens/search_ui.dart';
import 'package:dubai_local/screens/splash_ui.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../bindings/categories_bindings.dart';
import '../../bindings/detail_binding.dart';
import '../../bindings/login_signup_bindings.dart';
import '../../bindings/main_home_binding.dart';
import '../../bindings/more_binding.dart';
import '../../bindings/search_binding.dart';
import '../../bindings/splash_binding.dart';
import '../../bindings/webview_binding.dart';
import '../../screens/main_business_ui.dart';
import '../../screens/main_home_ui.dart';
import '../../screens/webview_screen_ui.dart';

class AppPages {
  static const initialRoute = AppRoutes.home;
  static final route = [
    GetPage(
        name: AppRoutes.home,
        page: () => const BottomNav(),
        binding: HomeBinding(),
        ),
    GetPage(
        name: AppRoutes.mainBusiness,
        page: () => MainBusinessUI(),
        binding: MainBusinessBindings(),
        ),
    GetPage(
        name: AppRoutes.mainHome,
        page: () => const MainHomeUI(),
        binding: MainHomeBinding(),
        ),
    GetPage(
        name: AppRoutes.more,
        page: () => const MoreUI(),
        binding: MoreBinding(),
        ),
    GetPage(
        name: AppRoutes.search,
        page: () => const SearchUi(),
        binding: SearchBinding(),
        ),
    GetPage(
        name: AppRoutes.categories,
        page: () => const CategoriesUi(),
        binding: CategoriesBinding(),
        ),
    GetPage(
        name: AppRoutes.detail,
        page: () => const DetailUi(),
        binding: DetailBinding(),
        ),
    GetPage(
        name: AppRoutes.webview,
        page: () => const WebViewScreen(),
        binding: WebviewBinding(),
        ),
    GetPage(
        name: AppRoutes.splash,
        page: () => const SplashUI(),
        binding: SplashBinding(),
      transition: Transition.native
        ),
    GetPage(
        name: AppRoutes.loginSignUp,
        page: () => const LoginSignUpUI(),
        binding: LoginSignUpBinding(),
        ),
  ];
}
