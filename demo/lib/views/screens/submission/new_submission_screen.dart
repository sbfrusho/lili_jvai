import 'package:demo/views/screens/submission/submission_thanks_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custom_button.dart';
import 'package:demo/controllers/lilli_controllers/submission_controller.dart';
import 'package:demo/models/lilli_models/submission_model.dart';
import 'package:demo/utils/lilli_utils/custom_text_field.dart';

class AddSubmissionScreen extends StatelessWidget {
  AddSubmissionScreen({super.key});

  final SubmissionController controller = Get.find<SubmissionController>();

  final TextEditingController sourceController = TextEditingController();
  final TextEditingController knownController = TextEditingController();
  final TextEditingController contextController = TextEditingController();
  final RxString selectedCategory = ''.obs;

  final List<String> categories = [
    'Body Parts',
    'General',
    'Essentials',
    'Food',
    'Nature',
  ];

  Widget buildSection({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    final today = DateFormat('dd MMM yyyy').format(DateTime.now());

    double verticalSpace(double fraction) => screenHeight * fraction;
    double fontSize(double size) => size * (screenWidth / 375);
    double radius(double r) => r * (screenWidth / 375);

    return CommonPage(
      showAppBar: true,
      text: "Add New",
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Date ---
              SizedBox(height: verticalSpace(0.02)),
              Text(
                today,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize(18),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: verticalSpace(0.02)),

              // --- Scrollable Content ---
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // --- Category Section ---
                      buildSection(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Type / Category",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize(18),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: verticalSpace(0.005)),
                            Obx(
                              () => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.03,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(radius(12)),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.5),
                                    width: 0.5,
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  value: selectedCategory.value.isEmpty
                                      ? null
                                      : selectedCategory.value,
                                  isExpanded: true,
                                  dropdownColor: Colors.white.withOpacity(0.12),
                                  underline: const SizedBox(),
                                  hint: Text(
                                    "Select category",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: fontSize(16),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  // Selected value style (shows in main container)
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize(16),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),
                                  items: [
                                    // "Select one" option
                                    DropdownMenuItem<String>(
                                      value: "",
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: verticalSpace(0.012),
                                          horizontal: screenWidth * 0.03,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(radius(8)),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(0.5),
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Text(
                                          "Select one",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontSize(16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Category options with container, border, and tick
                                    ...categories.map((cat) {
                                      bool isSelected = selectedCategory.value == cat;
                                      return DropdownMenuItem<String>(
                                        value: cat,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: verticalSpace(0.012),
                                            horizontal: screenWidth * 0.03,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(radius(8)),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(0.5),
                                              width: 0.5,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                cat,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: fontSize(16),
                                                ),
                                              ),
                                              Container(
                                                width: screenWidth * 0.06,
                                                height: screenWidth * 0.06,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.transparent,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 0.5,
                                                  ),
                                                ),
                                                child: isSelected
                                                    ? Icon(
                                                        Icons.check,
                                                        color: Colors.black,
                                                        size: fontSize(14),
                                                      )
                                                    : null,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                  onChanged: (val) {
                                    selectedCategory.value = val ?? '';
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: verticalSpace(0.02)),

                      // --- Source Text ---
                      buildSection(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Source Text",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize(18),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: verticalSpace(0.005)),
                            CustomTextField(
                              label: "Enter text",
                              controller: sourceController,
                              radius: 12,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: verticalSpace(0.02)),

                      // --- Known Translation ---
                      buildSection(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Known Translation (IF any)",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize(18),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: verticalSpace(0.005)),
                            CustomTextField(
                              label: "Enter known translation",
                              controller: knownController,
                              radius: 12,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: verticalSpace(0.02)),

                      // --- Context / Notes ---
                      buildSection(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add Context or Notes",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize(18),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: verticalSpace(0.005)),
                            CustomTextField(
                              label: "Enter context or notes",
                              controller: contextController,
                              radius: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: verticalSpace(0.02)),

              // --- Submit Button ---
              CustomButton(
                title: "Submit",
                backgroundColor: Colors.white.withOpacity(0.2),
                width: double.infinity,
                height: 56,
                borderRadius: radius(20),
                onTap: () {
                  if (sourceController.text.isEmpty ||
                      selectedCategory.value.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Source and Category are required",
                      backgroundColor: Colors.red.withOpacity(0.7),
                      colorText: Colors.white,
                    );
                    return;
                  }
                  controller.addSubmission(
                    SubmissionModel(
                      source: sourceController.text,
                      known: knownController.text,
                      category: selectedCategory.value,
                    ),
                  );
                  Get.to(
                    () => SubmissionThanksScreen(),
                    transition: Transition.noTransition,
                    duration: const Duration(milliseconds: 0),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}