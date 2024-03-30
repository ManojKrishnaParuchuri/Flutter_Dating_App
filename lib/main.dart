import 'package:dating_app/authentication_screen/login_page.dart';
import 'package:dating_app/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();



  Get.put(AuthenticationController());



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dating App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: Loginpage(),
    );
  }
}

