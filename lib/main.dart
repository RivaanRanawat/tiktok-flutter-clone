// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tiktok_tutorial/constants.dart';
// import 'package:tiktok_tutorial/controllers/auth_controller.dart';
import 'package:tiktok_tutorial/views/screens/auth/login_screen.dart';
// import 'package:tiktok_tutorial/views/screens/auth/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://swaoxzcuelanpcmlpsjs.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN3YW94emN1ZWxhbnBjbWxwc2pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI5Nzk3NTcsImV4cCI6MjAwODU1NTc1N30.azkfQFTJvrF3EdkOfNm0bJGzz0MyKM7hQ3ykv2Df-Og',
  );

  // await Firebase.initializeApp().then((value) {
  //   Get.put(AuthController());
  // });
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
