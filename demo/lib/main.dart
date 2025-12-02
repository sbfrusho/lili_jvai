import 'package:demo/controllers/lilli_controllers/bottom_navigation_controller.dart';
import 'package:demo/controllers/lilli_controllers/submission_controller.dart';
import 'package:demo/views/screens/AI%20Screen/ai_update_screen.dart';
import 'package:demo/views/screens/Authentication/splash_screen.dart';
import 'package:demo/views/screens/Home%20Screen/home_screen.dart';
import 'package:demo/views/screens/favourite/favourite_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize controllers globally
  Get.put(BottomNavController());
  Get.put(SubmissionController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
    );
  }
}