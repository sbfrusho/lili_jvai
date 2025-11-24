import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslationController extends GetxController {
  // Text controller for search input
  final searchController = TextEditingController();

  // Observable variables
  final RxString sourceLanguage = 'English'.obs;
  final RxString targetLanguage = 'Marshallese'.obs;
  final RxString searchQuery = ''.obs;
  final RxString translationResult = ''.obs;

  // Recent translations list
  final RxList<Map<String, String>> recentTranslations =
      <Map<String, String>>[].obs;

  // Search results (3 synonym boxes)
  final RxList<Map<String, String>> searchResults =
      <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // Called whenever the search text changes
  void _onSearchChanged() {
    searchQuery.value = searchController.text;

    if (searchController.text.isNotEmpty) {
      _debounceSearch();
    } else {
      translationResult.value = '';
      searchResults.clear();
    }
  }

  // Prevents immediate search — waits for user to stop typing
  void _debounceSearch() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (searchController.text == searchQuery.value) {
        performSearch(); // show synonym boxes
        translate();     // translation
      }
    });
  }

  /// Swap source and target languages
  void swapLanguages() {
    final temp = sourceLanguage.value;
    sourceLanguage.value = targetLanguage.value;
    targetLanguage.value = temp;

    if (searchController.text.isNotEmpty) {
      translate();
      performSearch();
    }
  }

  // ---------------------------------------------------------------------------
  //  SYNONYM BOXES (Under Search Bar)
  // ---------------------------------------------------------------------------
  void performSearch() {
    final query = searchController.text.trim();
    if (query.isEmpty) return;

    searchResults.clear();

    // Mock synonyms (Replace with real API later)
    searchResults.assignAll([
      {"synonym": "$query meaning 1", "category": "General"},
      {"synonym": "$query meaning 2", "category": "Usage"},
      {"synonym": "$query meaning 3", "category": "Context"},
    ]);
  }

  // ---------------------------------------------------------------------------
  //  TRANSLATION LOGIC
  // ---------------------------------------------------------------------------
  void translate() async {
    final text = searchController.text.trim();
    if (text.isEmpty) return;

    translationResult.value = 'Searching...';

    try {
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock translation (returns same text)
      translationResult.value = text;

      // Save to recent list
      _addToRecent(text, translationResult.value);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Translation failed: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Save translation to recent list
/// Add to recent translations (no duplicates)
void _addToRecent(String original, String translated) {
  // Create new translation map
  final newTranslation = {
    'english': sourceLanguage.value == 'English' ? original : translated,
    'marshallese':
        sourceLanguage.value == 'Marshallese' ? original : translated,
    'category': 'General',
  };

  // Remove existing entry if already in recent
  recentTranslations.removeWhere((element) =>
      element['english'] == newTranslation['english'] &&
      element['marshallese'] == newTranslation['marshallese']);

  // Insert new at top
  recentTranslations.insert(0, newTranslation);

  // Keep only latest 10
  if (recentTranslations.length > 10) {
    recentTranslations.removeLast();
  }
}


  // Clear input and results
  void clearSearch() {
    searchController.clear();
    translationResult.value = '';
    searchResults.clear();
  }

  // Image upload (Future OCR integration)
  void uploadImage() async {
    Get.snackbar(
      'Image Upload',
      'Select an image to translate',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );

    await Future.delayed(const Duration(seconds: 2));

    searchController.text = 'Bone';
    translate();
    performSearch();
  }


  // Show details of a translation
  void openTranslationDetail(Map<String, String> translation) {
    Get.snackbar(
      'Translation',
      '${translation['english']} → ${translation['marshallese']}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
