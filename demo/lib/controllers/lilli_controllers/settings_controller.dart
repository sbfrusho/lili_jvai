import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxBool pushNotification = false.obs;

  void togglePushNotification(bool value) {
    pushNotification.value = value;
  }
}
