import 'package:demo/views/screens/AI%20Screen/ai_list_screen.dart';
import 'package:demo/views/screens/Home%20Screen/home_screen.dart';
import 'package:demo/views/screens/favourite/favourite_screen.dart';
import 'package:demo/views/screens/submission/submission_list_screen.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // Observable variable for selected index
  final RxInt selectedIndex = 0.obs;

  // Change selected tab
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  // Navigate to Home screen
  void navigateToHome() {
    selectedIndex.value = 0;
    Get.to(
      () => HomeScreen(),
      transition: Transition.noTransition,
      duration: const Duration(seconds: 0),
    );
  }

  // Navigate to Favorite screen
  void navigateToFavorite() {
    selectedIndex.value = 1;
    Get.to(
      () => FavoritesScreen(),
      transition: Transition.noTransition,
      duration: const Duration(seconds: 0),
    );
  }

  // Navigate to Submission screen
  void navigateToSubmissionScreen() {
    selectedIndex.value = 2;
    Get.to(
      () => SubmissionListScreen(),
      transition: Transition.noTransition,
      duration: const Duration(seconds: 0),
    );
  }

  // Navigate to AI screen
  void navigateToAIScreen() {
    selectedIndex.value = 3;
    Get.to(
      () => AiListScreen(),
      transition: Transition.noTransition,
      duration: const Duration(seconds: 0),
    );
  }

  // Legacy methods (kept for backward compatibility)
  void navigateToSubmission() {
    navigateToSubmissionScreen();
  }

  void navigateToAI() {
    navigateToAIScreen();
  }
}