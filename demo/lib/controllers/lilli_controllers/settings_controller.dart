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
  }
}
