// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:demo/controllers/translation_home_controller.dart';

// // 🎯 TOP BAR COMPONENT
// class TopBar extends StatelessWidget {
//   final TranslationHomeController controller;
//   final double horizontalPadding;

//   const TopBar({
//     super.key,
//     required this.controller,
//     required this.horizontalPadding,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: horizontalPadding,
//         vertical: 12,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _buildLogo(),
//           _buildRightIcons(),
//         ],
//       ),
//     );
//   }

//   Widget _buildLogo() {
//     return Container(
//       width: 60,
//       height: 40,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: const Center(
//         child: Icon(
//           Icons.translate,
//           color: Color(0xFFFFCD60),
//           size: 24,
//         ),
//       ),
//     );
//   }

//   Widget _buildRightIcons() {
//     return Row(
//       children: [
//         _NotificationIcon(onTap: controller.openNotifications),
//         const SizedBox(width: 12),
//         _ProfileIcon(onTap: controller.openProfile),
//       ],
//     );
//   }
// }

// // 🔔 NOTIFICATION ICON WITH BADGE
// class _NotificationIcon extends StatelessWidget {
//   final VoidCallback onTap;

//   const _NotificationIcon({required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Stack(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(
//               Icons.notifications_outlined,
//               color: Colors.white,
//               size: 22,
//             ),
//           ),
//           Positioned(
//             right: 8,
//             top: 8,
//             child: Container(
//               width: 8,
//               height: 8,
//               decoration: const BoxDecoration(
//                 color: Colors.red,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // 👤 PROFILE ICON
// class _ProfileIcon extends StatelessWidget {
//   final VoidCallback onTap;

//   const _ProfileIcon({required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.3),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: const Icon(
//           Icons.person_outline,
//           color: Colors.white,
//           size: 22,
//         ),
//       ),
//     );
//   }
// }

// // 🔍 SEARCH CARD COMPONENT
// class SearchCard extends StatelessWidget {
//   final TranslationHomeController controller;

//   const SearchCard({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.white.withOpacity(0.3),
//           width: 2,
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(.08),
//           borderRadius: BorderRadius.circular(18),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               color: Colors.white.withOpacity(0.3),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _SearchHeader(controller: controller),
//                 const SizedBox(height: 12),
//                 _SearchInput(controller: controller),
//                 const SizedBox(height: 12),
//                 _TranslationOutput(controller: controller),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // 🔥 SEARCH HEADER (Label + Language Switch)
// class _SearchHeader extends StatelessWidget {
//   final TranslationHomeController controller;

//   const _SearchHeader({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             "Search",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//             ),
//           ),
//           _LanguageSwitcher(controller: controller),
//         ],
//       ),
//     );
//   }
// }

// // 🔄 LANGUAGE SWITCHER
// class _LanguageSwitcher extends StatelessWidget {
//   final TranslationHomeController controller;

//   const _LanguageSwitcher({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: controller.swapLanguages,
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 10,
//           vertical: 6,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.3),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               controller.sourceLanguage.value,
//               style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(width: 6),
//             const Icon(
//               Icons.swap_horiz,
//               color: Colors.white,
//               size: 16,
//             ),
//             const SizedBox(width: 6),
//             Text(
//               controller.targetLanguage.value,
//               style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // 🔎 SEARCH INPUT WITH MIC
// class _SearchInput extends StatelessWidget {
//   final TranslationHomeController controller;

//   const _SearchInput({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.5),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: controller.searchController,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//               ),
//               decoration: InputDecoration(
//                 hintText: "Type in English or Marshallese",
//                 hintStyle: TextStyle(
//                   color: Colors.white.withOpacity(0.7),
//                   fontSize: 13,
//                 ),
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: Colors.white.withOpacity(0.8),
//                   size: 20,
//                 ),
//                 suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
//                     ? IconButton(
//                         icon: const Icon(Icons.clear,
//                             color: Colors.white, size: 18),
//                         onPressed: controller.clearSearch,
//                       )
//                     : const SizedBox.shrink()),
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 12,
//                 ),
//               ),
//             ),
//           ),
//           _MicButton(controller: controller),
//         ],
//       ),
//     );
//   }
// }

// // 🎤 MIC BUTTON
// class _MicButton extends StatelessWidget {
//   final TranslationHomeController controller;

//   const _MicButton({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (controller.isRecording.value) {
//           controller.stopVoiceRecording();
//         } else {
//           controller.startVoiceRecording();
//         }
//       },
//       child: Obx(
//         () => Container(
//           margin: const EdgeInsets.only(right: 8),
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: controller.isRecording.value
//                   ? [Colors.red, Colors.red.shade700]
//                   : [const Color(0xFF9C6FDE), const Color(0xFF7B4FD1)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(
//             controller.isRecording.value ? Icons.stop : Icons.mic,
//             color: Colors.white,
//             size: 20,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // 📝 TRANSLATION OUTPUT
// class _TranslationOutput extends StatelessWidget {
//   final TranslationHomeController controller;

//   const _TranslationOutput({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Translation",
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Obx(
//           () => Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.4),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               controller.translationResult.value.isEmpty
//                   ? "Searching..."
//                   : controller.translationResult.value,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.white.withOpacity(0.9),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // 📌 RECENT TRANSLATIONS SECTION
// class RecentTranslationsSection extends StatelessWidget {
//   final TranslationHomeController controller;

//   const RecentTranslationsSection({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _SectionHeader(),
//         const SizedBox(height: 16),
//         _TranslationList(controller: controller),
//       ],
//     );
//   }
// }

// // 📋 SECTION HEADER
// class _SectionHeader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: const [
//         Icon(
//           Icons.history,
//           color: Colors.white,
//           size: 20,
//         ),
//         SizedBox(width: 8),
//         Text(
//           "Recent Translation",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // 📜 TRANSLATION LIST
// class _TranslationList extends StatelessWidget {
//   final TranslationHomeController controller;

//   const _TranslationList({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Column(
//         children: controller.recentTranslations.map((item) {
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 12),
//             child: TranslationItem(
//               item: item,
//               onTap: () => controller.openTranslationDetail(item),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// // 📄 TRANSLATION ITEM
// class TranslationItem extends StatelessWidget {
//   final Map<String, String> item;
//   final VoidCallback onTap;

//   const TranslationItem({
//     super.key,
//     required this.item,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.3),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _LanguageLabels(),
//                   const SizedBox(height: 4),
//                   _TranslationPair(
//                     english: item['english'] ?? "",
//                     marshallese: item['marshallese'] ?? "",
//                   ),
//                 ],
//               ),
//             ),
//             _CategoryTag(category: item['category'] ?? ""),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // 🏷️ LANGUAGE LABELS
// class _LanguageLabels extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           "English",
//           style: TextStyle(
//             color: Colors.white.withOpacity(0.8),
//             fontSize: 10,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(width: 12),
//         Text(
//           "Marshallese",
//           style: TextStyle(
//             color: Colors.white.withOpacity(0.8),
//             fontSize: 10,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // 💬 TRANSLATION PAIR
// class _TranslationPair extends StatelessWidget {
//   final String english;
//   final String marshallese;

//   const _TranslationPair({
//     required this.english,
//     required this.marshallese,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           english,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 15,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(width: 20),
//         Text(
//           marshallese,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 15,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // 🏷️ CATEGORY TAG
// class _CategoryTag extends StatelessWidget {
//   final String category;

//   const _CategoryTag({required this.category});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 10,
//         vertical: 5,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         category,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 11,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }