import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Documents/GitHub/testflutterflow2/lib/constants.dart';
import 'package:test_code_widget_dart/controllers/auth_controller.dart';
import 'package:test_code_widget_dart/views/screens/auth/login_screen.dart';
import 'package:test_code_widget_dart/views/screens/auth/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TikTok Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: LoginScreen(),
    );
  }
}
