import 'package:demo/views/base/Home%20Screen/home_screen.dart';
import 'package:demo/views/screens/favourite/favourite_screen.dart';
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
    Get.to(HomeScreen());
    selectedIndex.value = 0;
  }

  void navigateToFavorite() {
    Get.to(FavoritesPage());
    selectedIndex.value = 1;
  }

  void navigateToSubmission() {
    selectedIndex.value = 2;
  }

  void navigateToAI() {
    selectedIndex.value = 3;
  }
}