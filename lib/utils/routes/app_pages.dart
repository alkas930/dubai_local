import 'package:dubai_local/screens/login_signup.dart';
import 'package:dubai_local/bottomNav.dart';
import 'package:dubai_local/screens/splash_ui.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';

class AppPages {
  static const initialRoute = AppRoutes.splash;
  static final route = {
    AppRoutes.main: (context) => const BottomNav(),
    // AppRoutes.profile: (context) => const MyProfile(),
    // AppRoutes.mainBusiness: (context) => MainBusinessUI(),
    // AppRoutes.detail: (context) => const DetailUi(),
    // AppRoutes.webview: (context) => const WebViewScreen(),
    AppRoutes.splash: (context) => const SplashUI(),
    AppRoutes.loginSignUp: (context) => const LoginSignUpUI(),
  };
}
