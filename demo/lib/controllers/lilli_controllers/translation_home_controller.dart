// import 'package:demo/models/lilli_models/favorites_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class TranslationController extends GetxController {
//   // Text controller for search input
//   final searchController = TextEditingController();

//   // Observable variables
//   final RxString sourceLanguage = 'English'.obs;
//   final RxString targetLanguage = 'Marshallese'.obs;
//   final RxString searchQuery = ''.obs;
//   final RxString translationResult = ''.obs;
//   final RxString contextResult = ''.obs;

//   // Control visibility
//   final RxBool showRecentSection = true.obs;
//   final RxBool showContextSection = false.obs;
//   final RxBool isSearching = false.obs;
//   final RxBool isLoadingContext = false.obs;

//   // Track if user has performed a translation
//   final RxBool hasTranslated = false.obs;

//   // Recent translations list
//   final RxList<Map<String, String>> recentTranslations =
//       <Map<String, String>>[].obs;

//   // Favorite translations
//   final RxList<FavoriteModel> favoriteTranslations = <FavoriteModel>[].obs;

//   // Search results (3 synonym boxes)
//   final RxList<Map<String, String>> searchResults =
//       <Map<String, String>>[].obs;

//   // Mock translation database
//   final Map<String, String> translationDatabase = {
//     'hello': 'Yokwe',
//     'goodbye': 'Ewor jen',
//     'thank you': 'Kommol tata',
//     'yes': 'Aet',
//     'no': 'Jab',
//     'water': 'Dren',
//     'food': 'Mona',
//     'house': 'Im',
//     'family': 'Anij',
//     'friend': 'Ri-kaki',
//     'love': 'Jolet',
//     'peace': 'Ainemon',
//     'help': 'Jiban',
//     'book': 'Buk',
//     'school': 'Jikuul',
//     'bone': 'Bōn',
//   };

//   @override
//   void onInit() {
//     super.onInit();
//     searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void onClose() {
//     searchController.dispose();
//     super.onClose();
//   }

//   // ------------------ INTERNAL: HIDE RECENT ------------------
//   void _hideRecent() {
//     showRecentSection.value = false;
//   }

//   // Called whenever the search text changes
//   void _onSearchChanged() {
//     searchQuery.value = searchController.text;

//     if (searchController.text.isNotEmpty) {
//       // Hide recent if typing
//       _hideRecent();

//       // Only show suggestions if we haven't translated yet
//       if (!hasTranslated.value) {
//         _debounceSearch();
//       }
//     } else {
//       translationResult.value = '';
//       contextResult.value = '';
//       searchResults.clear();
//       showRecentSection.value = true;
//       showContextSection.value = false;
//       isSearching.value = false;
//       hasTranslated.value = false;
//     }
//   }

//   void _debounceSearch() {
//     Future.delayed(const Duration(milliseconds: 500), () {
//       if (searchController.text == searchQuery.value &&
//           !isSearching.value &&
//           !hasTranslated.value) {
//         performSearch(); // show synonym boxes
//       }
//     });
//   }

//   void swapLanguages() {
//     final temp = sourceLanguage.value;
//     sourceLanguage.value = targetLanguage.value;
//     targetLanguage.value = temp;

//     _hideRecent();

//     if (searchController.text.isNotEmpty && translationResult.value.isNotEmpty) {
//       // Swap the displayed values
//       final tempText = searchController.text;
//       searchController.text = translationResult.value;
//       translationResult.value = tempText;
//     }
//   }

//   void performSearch() {
//     final query = searchController.text.trim().toLowerCase();
//     if (query.isEmpty) return;

//     _hideRecent();

//     searchResults.clear();

//     // Generate 3 mock suggestions based on input
//     final List<Map<String, String>> suggestions = [];

//     // Add related words from database
//     translationDatabase.forEach((key, value) {
//       if (key.contains(query) || value.toLowerCase().contains(query)) {
//         suggestions.add({
//           "synonym": key,
//           "category": "Dictionary",
//         });
//       }
//     });

//     // If not enough suggestions, add generic ones
//     if (suggestions.isEmpty) {
//       suggestions.addAll([
//         {"synonym": "$query (common)", "category": "General"},
//         {"synonym": "$query (formal)", "category": "Usage"},
//         {"synonym": "$query (informal)", "category": "Context"},
//       ]);
//     }

//     // Take only first 3 suggestions
//     searchResults.assignAll(suggestions.take(3).toList());
//   }

//   // Handle suggestion click
//   void selectSuggestion(Map<String, String> suggestion) {
//     final selectedWord = suggestion['synonym'] ?? '';
//     // Remove any parenthetical text like "(common)"
//     final cleanWord = selectedWord.replaceAll(RegExp(r'\s*\([^)]*\)'), '').trim();

//     searchController.text = cleanWord;
//     searchQuery.value = cleanWord;

//     // Hide suggestions
//     searchResults.clear();

//     // Hide recent section
//     _hideRecent();

//     // Trigger translation automatically
//     hasTranslated.value = false;
//     isSearching.value = false;
//     translate();
//   }

//   // Trigger translation (called by search icon inside input)
//   void triggerSearchIconAction() {
//     if (searchController.text.trim().isEmpty) {
//       Get.snackbar(
//         'Empty Search',
//         'Please enter a word to translate',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.orange,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     isSearching.value = true;
//     hasTranslated.value = true;

//     _hideRecent();

//     // Hide suggestions
//     searchResults.clear();

//     // Show translation
//     translate();
//   }

//   Future<void> translate() async {
//     final text = searchController.text.trim().toLowerCase();
//     if (text.isEmpty) return;

//     translationResult.value = 'Searching...';
//     showContextSection.value = false;
//     hasTranslated.value = true;

//     _hideRecent();

//     try {
//       await Future.delayed(const Duration(milliseconds: 800));

//       String translated = '';

//       // Check if translating from English to Marshallese
//       if (sourceLanguage.value == 'English') {
//         translated = translationDatabase[text] ?? text.split('').reversed.join();
//       } else {
//         // Reverse lookup for Marshallese to English
//         final entry = translationDatabase.entries.firstWhere(
//           (entry) => entry.value.toLowerCase() == text,
//           orElse: () => MapEntry(text, text.split('').reversed.join()),
//         );
//         translated = entry.key;
//       }

//       translationResult.value = translated;

//       _addToRecent(text, translated);
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Translation failed: $e',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }

//   void _addToRecent(String original, String translated) {
//     final newTranslation = {
//       'english': sourceLanguage.value == 'English' ? original : translated,
//       'marshallese': sourceLanguage.value == 'Marshallese' ? original : translated,
//       'category': 'General',
//     };

//     // Remove duplicates
//     recentTranslations.removeWhere((element) =>
//         element['english'] == newTranslation['english'] &&
//         element['marshallese'] == newTranslation['marshallese']);

//     recentTranslations.insert(0, newTranslation);

//     // Keep only last 10
//     if (recentTranslations.length > 10) {
//       recentTranslations.removeLast();
//     }
//   }

//   void clearSearch() {
//     searchController.clear();
//     translationResult.value = '';
//     contextResult.value = '';
//     searchResults.clear();
//     showContextSection.value = false;
//     isSearching.value = false;
//     isLoadingContext.value = false;
//     hasTranslated.value = false;

//     showRecentSection.value = true;
//   }

//   // Generate AI Context
//   Future<void> generateAIContext() async {
//     if (searchController.text.trim().isEmpty || translationResult.value.isEmpty) {
//       return;
//     }

//     isLoadingContext.value = true;
//     showContextSection.value = true;
//     contextResult.value = 'Generating AI context...';

//     _hideRecent();

//     try {
//       await Future.delayed(const Duration(milliseconds: 1500));

//       final word = searchController.text.trim();

//       final contexts = {
//         'hello':
//             'The word "hello" translates to "Yokwe" in Marshallese. This is the most common greeting in the Marshall Islands. "Yokwe" expresses warmth and friendship, and is used both when meeting someone and when saying goodbye. The Marshall Islands culture places great importance on hospitality and welcoming others.',

//         'bone':
//             'The human body is a complex and fascinating system made up of billions of cells working together to sustain life. It includes major systems such as the skeletal, muscular, circulatory, respiratory, digestive, nervous, and reproductive, each performing specific functions essential for survival.',

//         'thank you':
//             'The phrase "thank you" translates to "Kommol tata" in Marshallese. "Kommol" means thanks or gratitude, while "tata" adds emphasis, similar to saying "very much" in English. Expressing gratitude is deeply valued in Marshallese culture, where showing appreciation strengthens community bonds.',

//         'water':
//             'The word "water" translates to "Dren" in Marshallese. Water holds immense cultural and practical significance in the Marshall Islands, an atoll nation surrounded by the Pacific Ocean. Fresh water has historically been precious due to limited natural sources on coral atolls.',

//         'food':
//             'The word "food" translates to "Mona" in Marshallese. Traditional Marshallese cuisine centers around seafood, coconuts, and breadfruit. "Mona" encompasses not just sustenance but also the cultural practice of sharing meals, which is fundamental to Marshallese social life.',
//       };

//       contextResult.value = contexts[word.toLowerCase()] ??
//           'The word "$word" is part of the rich linguistic heritage of the Marshall Islands, a Micronesian nation located in the Pacific Ocean. The Marshallese language belongs to the Malayo-Polynesian family of languages and has approximately 44,000 speakers. Understanding these translations helps bridge cultural connections and preserves important linguistic traditions.';

//       isLoadingContext.value = false;
//     } catch (e) {
//       contextResult.value = 'Failed to generate context. Please try again.';
//       isLoadingContext.value = false;
//     }
//   }

//   // Trigger AI Context generation from button
//   void triggerAISearch() async {
//     if (searchController.text.trim().isEmpty) {
//       Get.snackbar(
//         'Empty Search',
//         'Please enter a word first',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.orange,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     if (translationResult.value.isEmpty ||
//         translationResult.value == 'Searching...') {
//       isSearching.value = true;
//       showRecentSection.value = false;
//       hasTranslated.value = true;
//       await translate();
//     }

//     await generateAIContext();
//   }

//   void openTranslationDetail(Map<String, String> translation) {
//     searchController.text = translation['english'] ?? '';
//     translationResult.value = translation['marshallese'] ?? '';
//     searchResults.clear();

//     _hideRecent();

//     isSearching.value = true;
//     showContextSection.value = false;
//     hasTranslated.value = true;
//   }

//   // Download translation as PDF
//   void downloadTranslation() {
//     if (translationResult.value.isEmpty || translationResult.value == 'Searching...') {
//       return;
//     }

//     Get.snackbar(
//       'Download PDF',
//       'Translation downloaded successfully',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.green,
//       colorText: Colors.white,
//       duration: const Duration(seconds: 2),
//     );
//   }

//   // Copy translation to clipboard
//   void copyTranslation() async {
//     if (translationResult.value.isEmpty || translationResult.value == 'Searching...') {
//       return;
//     }

//     final englishWord = sourceLanguage.value == 'English'
//         ? searchController.text.trim()
//         : translationResult.value;
//     final marshalleseWord = sourceLanguage.value == 'Marshallese'
//         ? searchController.text.trim()
//         : translationResult.value;

//     String copyText = 'English - $englishWord\nMarshallese - $marshalleseWord';

//     if (contextResult.value.isNotEmpty &&
//         contextResult.value != 'Generating AI context...') {
//       copyText += '\nContext - ${contextResult.value}';
//     }

//     await Clipboard.setData(ClipboardData(text: copyText));

//     Get.snackbar(
//       'Copied',
//       'Translation copied to clipboard',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.blue,
//       colorText: Colors.white,
//       duration: const Duration(seconds: 2),
//     );
//   }

//   // ---------------- FAVORITES FUNCTIONS ----------------
//   void addToFavorites(FavoriteModel translation) {
//     if (!isFavorite(translation)) {
//       favoriteTranslations.insert(0, translation);
//     }
//     _hideRecent();
//   }

//   void removeFromFavorites(FavoriteModel translation) {
//     favoriteTranslations.removeWhere((element) =>
//         element.english == translation.english &&
//         element.marshallese == translation.marshallese);
//     _hideRecent();
//   }

//   void toggleFavorite(FavoriteModel translation) {
//     if (isFavorite(translation)) {
//       removeFromFavorites(translation);
//     } else {
//       addToFavorites(translation);
//     }
//   }

//   bool isFavorite(FavoriteModel translation) {
//     return favoriteTranslations.any((element) =>
//         element.english == translation.english &&
//         element.marshallese == translation.marshallese);
//   }
// }
import 'package:demo/models/lilli_models/favorites_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TranslationController extends GetxController {
  // Text controller for search input
  final searchController = TextEditingController();

  // Observable variables
  final RxString sourceLanguage = 'English'.obs;
  final RxString targetLanguage = 'Marshallese'.obs;
  final RxString searchQuery = ''.obs;
  final RxString translationResult = ''.obs;
  final RxString contextResult = ''.obs;
  
  // Control visibility
  final RxBool showRecentSection = true.obs;
  final RxBool showContextSection = false.obs;
  final RxBool showTranslationSection = false.obs; // NEW: controls Download/Copy buttons
  final RxBool isSearching = false.obs;
  final RxBool isLoadingContext = false.obs;

  // Track if user has performed a translation
  final RxBool hasTranslated = false.obs;

  // Recent translations list
  final RxList<Map<String, String>> recentTranslations =
      <Map<String, String>>[].obs;

  // Favorite translations
  final RxList<FavoriteModel> favoriteTranslations = <FavoriteModel>[].obs;

  // Search results (3 synonym boxes)
  final RxList<Map<String, String>> searchResults =
      <Map<String, String>>[].obs;

  // Mock translation database
  final Map<String, String> translationDatabase = {
    'hello': 'Yokwe',
    'goodbye': 'Ewor jen',
    'thank you': 'Kommol tata',
    'yes': 'Aet',
    'no': 'Jab',
    'water': 'Dren',
    'food': 'Mona',
    'house': 'Im',
    'family': 'Anij',
    'friend': 'Ri-kaki',
    'love': 'Jolet',
    'peace': 'Ainemon',
    'help': 'Jiban',
    'book': 'Buk',
    'school': 'Jikuul',
    'bone': 'Bōn',
  };

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
      showRecentSection.value = false; // hide recent whenever typing
      showTranslationSection.value = false; // hide Download/Copy until search complete
      _debounceSearch();
    } else {
      clearSearch();
    }
  }

  void _debounceSearch() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (searchController.text == searchQuery.value && !isSearching.value && !hasTranslated.value) {
        performSearch();
      }
    });
  }

  void swapLanguages() {
    final temp = sourceLanguage.value;
    sourceLanguage.value = targetLanguage.value;
    targetLanguage.value = temp;

    if (searchController.text.isNotEmpty && translationResult.value.isNotEmpty) {
      final tempText = searchController.text;
      searchController.text = translationResult.value;
      translationResult.value = tempText;
    }
  }

  void performSearch() {
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) return;

    searchResults.clear();

    final List<Map<String, String>> suggestions = [];
    translationDatabase.forEach((key, value) {
      if (key.contains(query) || value.toLowerCase().contains(query)) {
        suggestions.add({"synonym": key, "category": "Dictionary"});
      }
    });

    if (suggestions.isEmpty) {
      suggestions.addAll([
        {"synonym": "$query (common)", "category": "General"},
        {"synonym": "$query (formal)", "category": "Usage"},
        {"synonym": "$query (informal)", "category": "Context"},
      ]);
    }

    searchResults.assignAll(suggestions.take(3).toList());
  }

  void selectSuggestion(Map<String, String> suggestion) {
    final selectedWord = suggestion['synonym'] ?? '';
    final cleanWord = selectedWord.replaceAll(RegExp(r'\s*\([^)]*\)'), '').trim();
    
    searchController.text = cleanWord;
    searchQuery.value = cleanWord;
    searchResults.clear();

    hasTranslated.value = false;
    isSearching.value = false;
    showRecentSection.value = false; // hide recent
    translate();
  }

  void triggerSearchIconAction() {
    if (searchController.text.trim().isEmpty) {
      Get.snackbar(
        'Empty Search',
        'Please enter a word to translate',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }
    
    isSearching.value = true;
    hasTranslated.value = true;
    showRecentSection.value = false;
    searchResults.clear();
    translate();
  }

  Future<void> translate() async {
    final text = searchController.text.trim().toLowerCase();
    if (text.isEmpty) return;

    translationResult.value = 'Searching...';
    showContextSection.value = false;
    showTranslationSection.value = false; // hide until translation complete
    hasTranslated.value = true;
    showRecentSection.value = false;

    try {
      await Future.delayed(const Duration(milliseconds: 800));

      String translated = '';
      if (sourceLanguage.value == 'English') {
        translated = translationDatabase[text] ?? text.split('').reversed.join();
      } else {
        final entry = translationDatabase.entries.firstWhere(
          (entry) => entry.value.toLowerCase() == text,
          orElse: () => MapEntry(text, text.split('').reversed.join()),
        );
        translated = entry.key;
      }

      translationResult.value = translated;

      _addToRecent(text, translated);

      // Show download & copy buttons
      showTranslationSection.value = true;
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

  void _addToRecent(String original, String translated) {
    final newTranslation = {
      'english': sourceLanguage.value == 'English' ? original : translated,
      'marshallese': sourceLanguage.value == 'Marshallese' ? original : translated,
      'category': 'General',
    };

    recentTranslations.removeWhere((element) =>
        element['english'] == newTranslation['english'] &&
        element['marshallese'] == newTranslation['marshallese']);

    recentTranslations.insert(0, newTranslation);

    if (recentTranslations.length > 10) recentTranslations.removeLast();
  }

  void clearSearch() {
    searchController.clear();
    translationResult.value = '';
    contextResult.value = '';
    searchResults.clear();
    showRecentSection.value = true;
    showContextSection.value = false;
    showTranslationSection.value = false;
    isSearching.value = false;
    isLoadingContext.value = false;
    hasTranslated.value = false;
  }

  Future<void> generateAIContext() async {
    if (searchController.text.trim().isEmpty || translationResult.value.isEmpty) return;

    isLoadingContext.value = true;
    showContextSection.value = true;
    contextResult.value = 'Generating AI context...';

    try {
      await Future.delayed(const Duration(milliseconds: 1500));

      final word = searchController.text.trim();
      final contexts = {
        'hello': 'The word "hello" translates to "Yokwe" in Marshallese...',
        'bone': 'The human body is a complex system...',
        'thank you': 'The phrase "thank you" translates to "Kommol tata"...',
        'water': 'The word "water" translates to "Dren"...',
        'food': 'The word "food" translates to "Mona"...',
      };

      contextResult.value = contexts[word.toLowerCase()] ??
        'The word "$word" is part of the rich linguistic heritage...';

      isLoadingContext.value = false;
      showTranslationSection.value = true; // also show buttons after AI context
    } catch (e) {
      contextResult.value = 'Failed to generate context. Please try again.';
      isLoadingContext.value = false;
    }
  }

  void triggerAISearch() async {
    if (searchController.text.trim().isEmpty) {
      Get.snackbar(
        'Empty Search',
        'Please enter a word first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (translationResult.value.isEmpty || translationResult.value == 'Searching...') {
      isSearching.value = true;
      showRecentSection.value = false;
      hasTranslated.value = true;
      await translate();
    }

    await generateAIContext();
  }

  void openTranslationDetail(Map<String, String> translation) {
    searchController.text = translation['english'] ?? '';
    translationResult.value = translation['marshallese'] ?? '';
    searchResults.clear();

    isSearching.value = true;
    showRecentSection.value = false;
    showContextSection.value = false;
    hasTranslated.value = true;
    showTranslationSection.value = true; // show buttons
  }

  void downloadTranslation() {
    if (translationResult.value.isEmpty || translationResult.value == 'Searching...') return;

    Get.snackbar(
      'Download PDF',
      'Translation downloaded successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void copyTranslation() async {
    if (translationResult.value.isEmpty || translationResult.value == 'Searching...') return;

    final englishWord = sourceLanguage.value == 'English' 
        ? searchController.text.trim() 
        : translationResult.value;
    final marshalleseWord = sourceLanguage.value == 'Marshallese' 
        ? searchController.text.trim() 
        : translationResult.value;

    String copyText = 'English - $englishWord\nMarshallese - $marshalleseWord';

    if (contextResult.value.isNotEmpty && contextResult.value != 'Generating AI context...') {
      copyText += '\nContext - ${contextResult.value}';
    }

    await Clipboard.setData(ClipboardData(text: copyText));

    Get.snackbar(
      'Copied',
      'Translation copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  // ---------------- FAVORITES ----------------
  void addToFavorites(FavoriteModel translation) {
    if (!isFavorite(translation)) {
      favoriteTranslations.insert(0, translation);
      print("Added to favorites: ${translation.english} -> ${translation.marshallese}");
    }
  }

  void removeFromFavorites(FavoriteModel translation) {
    favoriteTranslations.removeWhere((element) =>
        element.english == translation.english &&
        element.marshallese == translation.marshallese);
    print("Removed from favorites: ${translation.english} -> ${translation.marshallese}");
  }

  void toggleFavorite(FavoriteModel translation) {
    if (isFavorite(translation)) {
      removeFromFavorites(translation);
    } else {
      addToFavorites(translation);
    }
  }

  bool isFavorite(FavoriteModel translation) {
    return favoriteTranslations.any((element) =>
        element.english == translation.english &&
        element.marshallese == translation.marshallese);
  }
}
