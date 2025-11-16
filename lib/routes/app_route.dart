import 'package:get/get.dart';
import 'package:newsly/screen/profile_detail_screen.dart';
import 'package:newsly/screen/profile_screen.dart';
import 'package:newsly/screen/signin_screen.dart';
import 'package:newsly/screen/signup_screen.dart';
import 'package:newsly/screen/view_news_screen.dart';
import 'package:newsly/screen/welcome_screen.dart';

class AppRoute {
  static String profile = '/profile';
  static String viewNews = '/viewNews';
  static String signup = '/signup';
  static String signin = '/signin';
  static String welcome = '/welcome';
  static String editProfile = '/edit_profile';

  static final routes = [
    GetPage(name: profile, page: () => ProfileScreen()),
    GetPage(name: viewNews, page: () => ViewNewsScreen()),
    GetPage(name: signup, page: () => SignupScreen()),
    GetPage(name: signin, page: () => SignInScreen()),
    GetPage(name: welcome, page: () => WelcomeScreen()),
    GetPage(name: editProfile, page: () => ProfileDetailScreen()),
  ];
}