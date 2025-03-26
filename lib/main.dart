import 'package:flutter/material.dart';
import 'package:gcc_admin/routes/app_route.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GCC APP - Student',
      initialRoute: Routes.splash,
      getPages: AppPages.pages,
    );
  }
}
