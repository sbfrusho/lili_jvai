import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/translation_home_controller.dart';

class RecentTranslationWidget extends StatelessWidget {
  final TranslationController controller = Get.find<TranslationController>();

  RecentTranslationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Recent Translation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // List of Recent Translations
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.recentTranslations.length,
                  itemBuilder: (context, index) {
                    final translation = controller.recentTranslations[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () => controller.openTranslationDetail(translation),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'English',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.8),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          'Marshallese',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.8),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          translation['english']!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Text(
                                          translation['marshallese']!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "|${translation['category']}",
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}