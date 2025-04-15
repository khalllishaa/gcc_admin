import 'package:gcc_admin/bindings/menu_binding.dart';
import 'package:gcc_admin/bindings/signup_binding.dart';
import 'package:gcc_admin/bindings/welcome_binding.dart';
import 'package:gcc_admin/pages/home_page/journal/add_journal/add_journal.dart';
import 'package:gcc_admin/pages/home_page/journal/journal_page/journal.dart';
import 'package:gcc_admin/pages/home_page/journal/journal_page/journal_class.dart';
import 'package:gcc_admin/pages/home_page/journal/view_journal/view_journal.dart';
import 'package:gcc_admin/pages/home_page/schedule/add_schedule/add_schedule.dart';
import 'package:gcc_admin/pages/home_page/teacher/add_teacher/add_teacher.dart';
import 'package:gcc_admin/pages/home_page/Teacher/list_teacher/list_teacher.dart';
import 'package:gcc_admin/pages/class_page/class_page.dart';
import 'package:gcc_admin/pages/class_page/list_page/list_siswa.dart';
import 'package:gcc_admin/pages/class_page/report_page/list_report.dart';
import 'package:gcc_admin/pages/class_page/report_page/view_report.dart';
import 'package:gcc_admin/pages/home_page/schedule/schedule_page/schedule.dart';
import 'package:gcc_admin/pages/home_page/schedule/view_schedule/view_schedule.dart';
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
  static const listTeacher = '/list-teacher';
  static const addTeacher = '/add-teacher';
  static const schedule = '/schedule';
  static const viewSchedule = '/view-schedule';
  static const addSchedule = '/add-schedule';
  static const journal = '/journal';
  static const viewJournal = '/view-journal';
  static const addJournal = '/add-journal';
  static const journalClass = '/journal-class';
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
    GetPage(name: Routes.viewReport, page: () => ViewReport()),
    GetPage(name: Routes.listTeacher, page: () => Listteacher()),
    GetPage(name: Routes.addTeacher, page: () => Addteacher()),
    GetPage(name: Routes.schedule, page: () => Schedule()),
    GetPage(name: Routes.viewSchedule, page: () => ViewSchedule()),
    GetPage(name: Routes.addSchedule, page: () => AddSchedule()),
    GetPage(name: Routes.journal, page: () => Journal()),
    GetPage(name: Routes.viewJournal, page: () => ViewJournal()),
    GetPage(name: Routes.addJournal, page: () => AddJournal()),
    GetPage(name: Routes.journalClass, page: () => JournalClass()),
  ];
}
