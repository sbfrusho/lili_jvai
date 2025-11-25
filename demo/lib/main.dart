import 'package:demo/views/base/Home%20Screen/home_screen.dart';
import 'package:demo/views/screens/Authentication/splash_screen.dart';
import 'package:demo/views/screens/profile/about_us_screen.dart';
import 'package:demo/views/screens/profile/change_password_screen.dart';
import 'package:demo/views/screens/profile/profile_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: ProfileSettingsScreen()
    );
  }
}
