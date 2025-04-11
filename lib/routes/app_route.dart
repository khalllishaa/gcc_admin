import 'package:gcc_admin/bindings/menu_binding.dart';
import 'package:gcc_admin/bindings/signup_binding.dart';
import 'package:gcc_admin/bindings/welcome_binding.dart';
import 'package:gcc_admin/pages/class_page/class_page.dart';
import 'package:gcc_admin/pages/class_page/list_page/list_siswa.dart';
import 'package:gcc_admin/pages/class_page/report_page/list_report.dart';
import 'package:gcc_admin/pages/class_page/report_page/view_report.dart';
import 'package:gcc_admin/pages/main_menu/menu_page.dart';
import 'package:gcc_admin/pages/profile_page/profile_page.dart';
import 'package:gcc_admin/pages/signIn_signUp/signin_page.dart';
import 'package:gcc_admin/pages/signIn_signUp/signup_page.dart';
import 'package:get/get.dart';

import '../pages/splashscreen_welcome/splash_screen.dart';
import '../pages/splashscreen_welcome/welcome_page.dart';

class Routes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const signin = '/signin';
  static const signup = '/signup';
  static const main = '/main';
  static const kelas = '/kelas';
  static const profile = '/profile';
  static const listSiswa = '/list-siswa';
  static const listReport = '/list-report';
  static const viewReport = '/view-report';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.splash, page: () => SplashScreen()),
    GetPage(
        name: Routes.welcome,
        page: () => WelcomePage(),
        binding: SignInBinding()),
    GetPage(
        name: Routes.signin,
        page: () => SigninPage(),
        binding: SignInBinding()),
    GetPage(
        name: Routes.signup,
        page: () => SignupPage(),
        binding: SignUpBinding()),
    GetPage(
        name: Routes.main, page: () => MainMenu(), binding: MainMenuBinding()),
    GetPage(name: Routes.kelas, page: () => ClassPage()),
    GetPage(name: Routes.profile, page: () => ProfilePage()),
    GetPage(name: Routes.listSiswa, page: () => ListStudent()),
    GetPage(name: Routes.listReport, page: () => ListReport()),
    GetPage(name: Routes.viewReport, page: () => ViewReport())
  ];
}
