import 'package:gcc_admin/bindings/list_teacher_binding.dart';
import 'package:gcc_admin/bindings/menu_binding.dart';
import 'package:gcc_admin/bindings/signup_binding.dart';
import 'package:gcc_admin/bindings/welcome_binding.dart';
import 'package:gcc_admin/pages/class_page/add_class.dart';
import 'package:gcc_admin/pages/class_page/edit_class.dart';
import 'package:gcc_admin/pages/class_page/report_page/add_report.dart';
import 'package:gcc_admin/pages/class_page/siswa_page/add_siswa.dart';
import 'package:gcc_admin/pages/class_page/siswa_page/edit_siswa.dart';
import 'package:gcc_admin/pages/home_page/journal/add_journal/add_journal.dart';
import 'package:gcc_admin/pages/home_page/journal/journal_page/journal.dart';
import 'package:gcc_admin/pages/home_page/journal/journal_page/journal_class.dart';
import 'package:gcc_admin/pages/home_page/journal/view_journal/view_journal.dart';
import 'package:gcc_admin/pages/home_page/schedule/add_schedule/add_schedule.dart';
import 'package:gcc_admin/pages/home_page/teacher/add_teacher/add_teacher.dart';
import 'package:gcc_admin/pages/home_page/Teacher/list_teacher/list_teacher.dart';
import 'package:gcc_admin/pages/class_page/class_page.dart';
import 'package:gcc_admin/pages/class_page/siswa_page/list_siswa.dart';
import 'package:gcc_admin/pages/class_page/report_page/list_report.dart';
import 'package:gcc_admin/pages/class_page/report_page/view_report.dart';
import 'package:gcc_admin/pages/home_page/schedule/schedule_page/schedule.dart';
import 'package:gcc_admin/pages/home_page/schedule/view_schedule/view_schedule.dart';
import 'package:gcc_admin/pages/home_page/teacher/edit_teacher/edit_teacher.dart';
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
  static const addClass = '/add-class';
  static const editClass = '/edit-class';

  static const listSiswa = '/list-siswa';
  static const addSiswa = '/add-siswa';
  static const editSiswa = '/edit-siswa';

  static const listReport = '/list-report';
  static const viewReport = '/view-report';
  static const addReport = '/add-report';

  static const listTeacher = '/list-teacher';
  static const addTeacher = '/add-teacher';
  static const editTeacher = '/edit-teacher';

  static const schedule = '/schedule';
  static const viewSchedule = '/view-schedule';
  static const addSchedule = '/add-schedule';

  static const journal = '/journal';
  static const viewJournal = '/view-journal';
  static const addJournal = '/add-journal';
  static const journalClass = '/journal-class';

  static const profile = '/profile';

}

class AppPages {
  static final pages = [
    GetPage(name: Routes.splash, page: () => SplashScreen()),
    GetPage(name: Routes.welcome, page: () => WelcomePage(), binding: SignInBinding()),
    GetPage(name: Routes.signin, page: () => SigninPage(), binding: SignInBinding()),
    GetPage(name: Routes.signup, page: () => SignupPage(), binding: SignUpBinding()),
    GetPage(name: Routes.main, page: () => MainMenu(), binding: MainMenuBinding()),

    GetPage(name: Routes.kelas, page: () => ClassPage()),
    GetPage(name: Routes.addClass, page: () => AddClass()),
    GetPage(name: Routes.editClass, page: () => EditClass()),

    GetPage(name: Routes.listSiswa, page: () => ListStudent()),
    GetPage(name: Routes.addSiswa, page: () => AddStudent()),
    GetPage(name: Routes.editSiswa, page: () => EditStudent()),

    GetPage(name: Routes.listReport, page: () => ListReport()),
    GetPage(name: Routes.viewReport, page: () => ViewReport()),
    GetPage(name: Routes.addReport, page: () => AddReport()),

    GetPage(name: Routes.listTeacher, page: () => Listteacher(),binding: ListTeacherBinding()),
    GetPage(name: Routes.addTeacher, page: () => Addteacher()),
    GetPage(name: Routes.editTeacher, page: () => EditTeacher()),

    GetPage(name: Routes.schedule, page: () => Schedule()),
    GetPage(name: Routes.viewSchedule, page: () => ViewSchedule()),
    GetPage(name: Routes.addSchedule, page: () => AddSchedule()),

    GetPage(name: Routes.journal, page: () => Journal()),
    GetPage(name: Routes.viewJournal, page: () => ViewJournal()),
    GetPage(name: Routes.addJournal, page: () => AddJournal()),
    GetPage(name: Routes.journalClass, page: () => JournalClass()),

    GetPage(name: Routes.profile, page: () => ProfilePage()),

  ];
}
