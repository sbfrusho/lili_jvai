import 'package:get/get.dart';

class LogoutController extends GetxController {
  var isLogoutPopupVisible = false.obs;

  void showLogoutPopup() => isLogoutPopupVisible.value = true;
  void hideLogoutPopup() => isLogoutPopupVisible.value = false;

  void logout() {
    // TODO: Add your logout logic here
    hideLogoutPopup();
    print("User logged out!");
  }
}
