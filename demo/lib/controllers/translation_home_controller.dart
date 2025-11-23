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

  // Recent translations
  final RxList<Map<String, String>> recentTranslations =
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

  void _onSearchChanged() {
    searchQuery.value = searchController.text;
    if (searchController.text.isNotEmpty) {
      _debounceSearch();
    } else {
      translationResult.value = '';
    }
  }

  void _debounceSearch() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (searchController.text == searchQuery.value) {
        translate();
      }
    });
  }

  /// Swap source and target languages
  void swapLanguages() {
    final temp = sourceLanguage.value;
    sourceLanguage.value = targetLanguage.value;
    targetLanguage.value = temp;

    // Re-translate if text exists
    if (searchController.text.isNotEmpty) {
      translate();
    }
  }

  /// Mock translation function
  void translate() async {
    if (searchController.text.trim().isEmpty) return;

    translationResult.value = 'Searching...';
    try {
      await Future.delayed(const Duration(seconds: 1));
      translationResult.value = '${searchController.text}';

      // Add to recent translations
      _addToRecent(searchController.text, translationResult.value);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Translation failed: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Add translation to recent list
  void _addToRecent(String original, String translated) {
    final newTranslation = {
      'english': sourceLanguage.value == 'English' ? original : translated,
      'marshallese':
          sourceLanguage.value == 'Marshallese' ? original : translated,
      'category': 'General',
    };
    recentTranslations.insert(0, newTranslation);

    if (recentTranslations.length > 10) {
      recentTranslations.removeLast();
    }
  }

  /// Clear search input
  void clearSearch() {
    searchController.clear();
    translationResult.value = '';
  }

  /// Handle image upload
  void uploadImage() async {
    // TODO: implement actual image picker + OCR
    Get.snackbar(
      'Image Upload',
      'Pick an image to translate',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );

    // Simulate processing
    await Future.delayed(const Duration(seconds: 2));

    // Example: Mock extracted text from image
    searchController.text = 'Bone';
    translate();
  }

  /// Open translation detail
  void openTranslationDetail(Map<String, String> translation) {
    Get.snackbar(
      'Translation',
      '${translation['english']} → ${translation['marshallese']}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
