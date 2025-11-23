import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // Observable variable for selected index
  final RxInt selectedIndex = 0.obs;

  // Change selected tab
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  // Navigate to specific tab
  void navigateToHome() {
    selectedIndex.value = 0;
  }

  void navigateToFavorite() {
    selectedIndex.value = 1;
  }

  void navigateToSubmission() {
    selectedIndex.value = 2;
  }

  void navigateToAI() {
    selectedIndex.value = 3;
  }
}