import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  var isBasic = true.obs; // true for Basic, false for Premium
  var isMonthly = true.obs; // true for Monthly, false for Yearly

  void toggleSubscriptionType(bool basic) {
    isBasic.value = basic;
  }

  void toggleBillingType(bool monthly) {
    isMonthly.value = monthly;
  }
}