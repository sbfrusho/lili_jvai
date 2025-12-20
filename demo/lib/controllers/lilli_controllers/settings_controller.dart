import 'package:demo/controllers/lilli_controllers/login_controller.dart';
import 'package:demo/services/shared_prefs_service.dart';
import 'package:demo/views/screens/Authentication/login_screen.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxBool pushNotification = false.obs;
  RxBool isLogoutPopupVisible = false.obs;

  void togglePushNotification(bool val) => pushNotification.value = val;

  void showLogoutPopup() => isLogoutPopupVisible.value = true;
  void hideLogoutPopup() => isLogoutPopupVisible.value = false;

  void logout() {
    // Your logout logic here
    hideLogoutPopup();
    // Navigate to login page

  // CLEAR LOGIN FIELDS

  // final loginCtrl = Get.find<LoginController>();
  // loginCtrl.emailController.clear();
  // loginCtrl.passwordController.clear();
  // loginCtrl.emailError.value = "";
  // loginCtrl.passwordError.value = "";
  SharedPrefsService.remove("accessToken");
  SharedPrefsService.remove("refreshToken");
    Get.to(()=>LoginScreen(),transition: .noTransition,duration: Duration(seconds: 0));
  }
}
