import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AiUpdateController extends GetxController {
  RxBool isExpanded = false.obs;
  RxString selectedTranslation = "Previous Translation".obs;

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void selectTranslation(String value) {
    selectedTranslation.value = value;
    isExpanded.value = false;
  }
}

class AiUpdateScreen extends StatelessWidget {
  AiUpdateScreen({super.key});

  final AiUpdateController controller = Get.put(AiUpdateController());

  @override
  Widget build(BuildContext context) {
    return CommonPage(
      showBackButton: true,
      text: "AI Translation Feedback",
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth > 600 ? 32 : 20,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// ---------------------------------------------------------
                    /// DROPDOWN BOX SECTION
                    /// ---------------------------------------------------------
                    Obx(() => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: controller.isExpanded.value
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFFFFCB59),
                                      Color(0xFFF6A652),
                                      Color(0xFFDA610F),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )
                                : null,
                            color: controller.isExpanded.value
                                ? null
                                : Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              /// DROPDOWN HEADER
                              GestureDetector(
                                onTap: controller.toggleExpanded,
                                child: Container(
                                  padding: EdgeInsets.all(
                                    constraints.maxWidth > 600 ? 20 : 16,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: constraints.maxWidth > 600 ? 18 : 14,
                                      vertical: constraints.maxWidth > 600 ? 12 : 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: controller.isExpanded.value
                                          ? Colors.white.withOpacity(0.2)
                                          : Colors.white.withOpacity(0.08),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Obx(() => Text(
                                                controller.selectedTranslation.value,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      constraints.maxWidth > 600 ? 17 : 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        ),
                                        SizedBox(width: 8),
                                        Obx(() => Icon(
                                              controller.isExpanded.value
                                                  ? Icons.keyboard_arrow_up
                                                  : Icons.keyboard_arrow_down,
                                              color: Colors.white,
                                              size: constraints.maxWidth > 600 ? 28 : 24,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              /// DROPDOWN CONTENT
                              Obx(() => AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    child: controller.isExpanded.value
                                        ? Padding(
                                            padding: EdgeInsets.fromLTRB(
                                              constraints.maxWidth > 600 ? 20 : 16,
                                              0,
                                              constraints.maxWidth > 600 ? 20 : 16,
                                              constraints.maxWidth > 600 ? 20 : 16,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                /// SEARCH SECTION
                                                Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all(
                                                      constraints.maxWidth > 600 ? 12 : 10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(
                                                      color: Colors.white.withOpacity(0.5),
                                                      width: 0.5,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Search",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: constraints.maxWidth > 600
                                                              ? 16
                                                              : 14,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      SizedBox(height: 8),
                                                      CustomTextField(
                                                        label: "Bone",
                                                        prefixSvg: "assets/icons/search.svg",
                                                        height: constraints.maxWidth > 600 ? 52 : 48,
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(height: 12),

                                                /// TRANSLATION SECTION
                                                Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all(
                                                      constraints.maxWidth > 600 ? 12 : 10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(
                                                      color: Colors.white.withOpacity(0.5),
                                                      width: 0.5,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Translation",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: constraints.maxWidth > 600
                                                              ? 16
                                                              : 14,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      SizedBox(height: 8),
                                                      Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.all(
                                                            constraints.maxWidth > 600
                                                                ? 12
                                                                : 10),
                                                        decoration: BoxDecoration(
                                                          color:
                                                              Colors.white.withOpacity(0.15),
                                                          borderRadius:
                                                              BorderRadius.circular(10),
                                                          border: Border.all(
                                                            color:
                                                                Colors.white.withOpacity(0.3),
                                                            width: 0.5,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "Marshallese",
                                                              style: TextStyle(
                                                                color: Colors.white
                                                                    .withOpacity(0.8),
                                                                fontSize:
                                                                    constraints.maxWidth > 600
                                                                        ? 14
                                                                        : 13,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                            SizedBox(height: 4),
                                                            Text(
                                                              "Bon",
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize:
                                                                    constraints.maxWidth > 600
                                                                        ? 16
                                                                        : 15,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(height: 12),

                                                /// CONTEXT SECTION
                                                Container(
                                                  width: double.infinity,
                                                  constraints: BoxConstraints(
                                                    maxHeight: 200,
                                                  ),
                                                  padding: EdgeInsets.all(
                                                      constraints.maxWidth > 600 ? 12 : 10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(
                                                      color: Colors.white.withOpacity(0.5),
                                                      width: 0.5,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Context",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize:
                                                                  constraints.maxWidth > 600
                                                                      ? 16
                                                                      : 14,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  constraints.maxWidth > 600
                                                                      ? 8
                                                                      : 6,
                                                              vertical:
                                                                  constraints.maxWidth > 600
                                                                      ? 4
                                                                      : 3,
                                                            ),
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(6),
                                                              border: Border.all(
                                                                color: Colors.white
                                                                    .withOpacity(0.5),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              "Body Parts",
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize:
                                                                    constraints.maxWidth > 600
                                                                        ? 13
                                                                        : 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 8),
                                                      Expanded(
                                                        child: SingleChildScrollView(
                                                          child: Text(
                                                            "The human body is a complex and fascinating system made up of billions of cells working together to sustain life. It consists of several major systems, including the skeletal, muscular, circulatory, respiratory, digestive, nervous, and reproductive systems - each performing specific functions essential for survival.",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize:
                                                                  constraints.maxWidth > 600
                                                                      ? 14
                                                                      : 13,
                                                              height: 1.4,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  )),
                            ],
                          ),
                        )),

                    SizedBox(height: 16),

                    /// ---------------------------------------------------------
                    /// MAIN OUTER BOX (UPDATED TRANSLATION)
                    /// ---------------------------------------------------------
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight * 0.4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                          constraints.maxWidth > 600 ? 20 : 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// ---------------------------------------------------------
                            /// UPDATED TRANSLATION HEADER
                            /// ---------------------------------------------------------
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: constraints.maxWidth > 600 ? 16 : 12,
                                  horizontal: constraints.maxWidth > 600 ? 20 : 16,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Updated Translation",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: constraints.maxWidth > 600 ? 18 : 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_up,
                                      color: Colors.white,
                                      size: constraints.maxWidth > 600 ? 30 : 24,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 16),

                            /// ---------------------------------------------------------
                            /// SEARCH SECTION
                            /// ---------------------------------------------------------
                            Container(
                              width: double.infinity,
                              padding:
                                  EdgeInsets.all(constraints.maxWidth > 600 ? 10 : 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 0.5,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Search",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: constraints.maxWidth > 600 ? 16 : 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  CustomTextField(
                                    label: "Bone",
                                    prefixSvg: "assets/icons/search.svg",
                                    height: constraints.maxWidth > 600 ? 52 : 48,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 16),

                            /// ---------------------------------------------------------
                            /// TRANSLATION SECTION
                            /// ---------------------------------------------------------
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Translation",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: constraints.maxWidth > 600 ? 18 : 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.5),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        constraints.maxWidth > 600 ? 16 : 12),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 1,
                                          width: double.infinity,
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "Marshallese",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.8),
                                            fontSize: constraints.maxWidth > 600 ? 15 : 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          "Bon",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: constraints.maxWidth > 600 ? 18 : 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16),

                            /// ---------------------------------------------------------
                            /// CONTEXT SECTION
                            /// ---------------------------------------------------------
                            Container(
                              width: double.infinity,
                              constraints: BoxConstraints(
                                maxHeight: 200,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.13),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    constraints.maxWidth > 600 ? 16 : 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Context",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                constraints.maxWidth > 600 ? 17 : 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                constraints.maxWidth > 600 ? 10 : 8,
                                            vertical: constraints.maxWidth > 600 ? 6 : 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(0.5),
                                            ),
                                          ),
                                          child: Text(
                                            "Body Parts",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  constraints.maxWidth > 600 ? 14 : 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Text(
                                          "The human body is a complex and fascinating system made up of billions of cells working together to sustain life. It consists of several major systems, including the skeletal, muscular, circulatory, respiratory, digestive, nervous, and reproductive systems - each performing specific functions essential for survival.",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                constraints.maxWidth > 600 ? 15 : 14,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}