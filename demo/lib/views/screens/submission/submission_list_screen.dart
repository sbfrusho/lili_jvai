import 'package:demo/controllers/lilli_controllers/submission_controller.dart';
import 'package:demo/models/lilli_models/submission_model.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custom_button.dart';
import 'package:demo/utils/lilli_utils/custon_bottom_navbar.dart';
import 'package:demo/views/screens/submission/new_submission_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SubmissionListScreen extends StatelessWidget {
  SubmissionListScreen({super.key});

  final SubmissionController controller = Get.put(SubmissionController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final today = DateFormat('dd MMM yyyy').format(DateTime.now());
    return CommonPage(
      text: "Submission",
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// --- DATE AND NOTIFICATION ICON ROW ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      today,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/icons/notification_icon.svg",
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                /// --- SUBMISSION LIST ---
                Expanded(
                  child: Obx(() {
                    if (controller.submissions.isEmpty) {
                      return const Center(
                        child: Text(
                          "No submissions yet",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.submissions.length,
                      itemBuilder: (context, index) {
                        final item = controller.submissions[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                            item.known.isEmpty ? '-' : item.known,
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
                              /// --- Divider ---
                               const Spacer(),
                              Container(
                                width: 1,
                                height: 24,
                                color: Colors.white.withOpacity(0.4),
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                              ),
                              
                              /// --- Category & Delete Group ---
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    /// --- Category Column ---
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: Colors.white.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/icons/notification_delete.svg",
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
                        );
                      },
                    );
                  }),
                ),

                SizedBox(height: screenHeight * 0.02),

                /// --- ADD NEW BUTTON ---
                CustomButton(
                  title: "Add New Submission",
                  backgroundColor: Colors.white.withOpacity(0.2),
                  borderRadius: 12,
                  onTap: () {
                    Get.to(
                      () => AddSubmissionScreen(),
                      transition: Transition.noTransition,
                      duration: const Duration(seconds: 0),
                    );
                  },
                ),

                SizedBox(height: screenHeight * 0.1),
              ],
            ),
          ),

          /// --- Bottom Navbar ---
          Positioned(bottom: 0, left: 0, right: 0, child: CustomBottomNavBar()),
        ],
      ),
    );
  }
}