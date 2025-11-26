import 'package:demo/controllers/lilli_controllers/bottom_navigation_controller.dart';
import 'package:demo/controllers/lilli_controllers/submission_controller.dart';
import 'package:demo/views/screens/Subscription/basic_subscription.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: BasicSubscription()
    );
  }
}


