import 'package:quotes_app/headers.dart';
import 'package:quotes_app/pages/detail_page/detail_page.dart';
import '../pages/home_page/home_page.dart';
import '../pages/splash_screen/splash_screen.dart';

class AppRoutes {
  static String splashScreen = '/';
  static String homePage = 'home_page';
  static String detailpage = 'detail_page';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const SplashScreen(),
    homePage: (context) => const HomePage(),
    detailpage: (context) => const Detailpage(),
  };
}
