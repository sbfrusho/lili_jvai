
import 'package:demo/controllers/lilli_controllers/log_out_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/lilli_controllers/auth_controller.dart';
import '../controllers/theme_controller.dart';
import '../controllers/user_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);
    
    // Permanent controllers (stay in memory)
    Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
    Get.put(LogoutController());
    Get.put(UserController());
  }
}
