import 'package:dubai_local/screens/login_signup.dart';
import 'package:dubai_local/bottomNav.dart';
import 'package:dubai_local/screens/categories_ui.dart';
import 'package:dubai_local/screens/listing.dart';
import 'package:dubai_local/screens/more_ui.dart';
import 'package:dubai_local/screens/my_profile.dart';
import 'package:dubai_local/screens/search_ui.dart';
import 'package:dubai_local/screens/splash_ui.dart';
import 'package:dubai_local/utils/routes/app_routes.dart';
import '../../screens/main_business_ui.dart';
import '../../screens/webview_screen_ui.dart';

class AppPages {
  static const initialRoute = AppRoutes.splash;
  static final route = {
    AppRoutes.main: (context) => const BottomNav(),
    AppRoutes.profile: (context) => const MyProfile(),
    AppRoutes.mainBusiness: (context) => MainBusinessUI(),
    AppRoutes.detail: (context) => const DetailUi(),
    AppRoutes.webview: (context) => const WebViewScreen(),
    AppRoutes.splash: (context) => const SplashUI(),
    AppRoutes.loginSignUp: (context) => const LoginSignUpUI(),
  };
}
