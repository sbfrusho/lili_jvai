// ignore_for_file: unnecessary_string_interpolations, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custon_bottom_navbar.dart';
import 'package:demo/controllers/lilli_controllers/ai_submission_controller.dart';
import 'package:demo/views/screens/AI Screen/ai_update_screen.dart';

class AiListScreen extends StatelessWidget {
  AiListScreen({super.key});

  final AiSubmissionController controller = Get.put(AiSubmissionController());

  // Delete icon asset path
  final String deleteIcon = "assets/icons/notification_delete.svg";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final today = DateFormat('dd MMM   yyyy').format(DateTime.now());

    return CommonPage(
      text: "AI Translation Feedback",
      child: Stack(
        children: [
          /// MAIN CONTENT
          Padding(
            padding: EdgeInsets.only(bottom: 80), // Space for bottom nav
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.045,
                vertical: screenHeight * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// --- DATE ---
                  Text(
                    "$today",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),

                  /// --- SUBMISSION LIST ---
                  Expanded(
                    child: Obx(() {
                      if (controller.submissions.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Ai Translation yet",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.submissions.length,
                        itemBuilder: (context, index) {
                          final item = controller.submissions[index];

                          return GestureDetector(
                            onTap: () {
                              Get.to(() => AiUpdateScreen(), arguments: item);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 0.5,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /// --- Source & Known Group ---
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        /// --- Source Column ---
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Source",
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                item.source,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        /// --- Known Column ---
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Known",
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                item.known.isEmpty
                                                    ? '-'
                                                    : item.known,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// --- Spacer ---
                                  const Spacer(),

                                  /// --- Divider ---
                                  Container(
                                    width: 1,
                                    height: 40,
                                    color: Colors.white.withOpacity(0.4),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                  ),

                                  /// --- Category & Delete Group ---
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        /// --- Category Column ---
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 4),
                                              Text(
                                                item.category,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(width: 8),

                                        /// --- Delete Button ---
                                        GestureDetector(
                                          onTap: () {
                                            controller.removeSubmission(item);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(
                                                0.15,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: SvgPicture.asset(
                                              deleteIcon,
                                              width: 20,
                                              height: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),

          /// BOTTOM NAV BAR
          Positioned(left: 0, right: 0, bottom: 0, child: CustomBottomNavBar()),
        ],
      ),
    );
  }
}
