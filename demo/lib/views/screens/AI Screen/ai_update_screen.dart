import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custom_text_field.dart';
import 'package:flutter/material.dart';

class AiUpdateScreen extends StatelessWidget {
  const AiUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPage(
      showAppBar: true,
      text: "AI Translation Feedback",
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth > 600 ? 32 : 20,
              vertical: 16,
            ),
            child: Column(
              children: [
                /// ---------------------------------------------------------
                /// DROPDOWN BOX SECTION
                /// ---------------------------------------------------------
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      constraints.maxWidth > 600 ? 20 : 16,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth > 600 ? 18 : 14,
                        vertical: constraints.maxWidth > 600 ? 8 : 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          dropdownColor: Colors.black87,
                          value: "Previous Translation",
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: constraints.maxWidth > 600 ? 28 : 24,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: constraints.maxWidth > 600 ? 17 : 15,
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "Previous Translation",
                              child: Text(
                                "Previous Translation",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Option 1",
                              child: Text(
                                "Option 1",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Option 2",
                              child: Text(
                                "Option 2",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: constraints.maxHeight * 0.02),

                /// ---------------------------------------------------------
                /// MAIN OUTER BOX
                /// ---------------------------------------------------------
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        constraints.maxWidth > 600 ? 20 : 16,
                      ),
                      child: Column(
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
                                    Icons.arrow_drop_up,
                                    color: Colors.white,
                                    size: constraints.maxWidth > 600 ? 30 : 24,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: constraints.maxHeight * 0.02),

                          /// ---------------------------------------------------------
                          /// SEARCH SECTION - REDUCED SIZE
                          /// ---------------------------------------------------------
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(constraints.maxWidth > 600 ? 10 : 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                                width: 0.5,
                              ),
                            ),
                            child: Column(
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
                                SizedBox(height: constraints.maxHeight * 0.01),
                                const CustomTextField(
                                  label: "Bone",
                                  prefixSvg: "assets/icons/search.svg",
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: constraints.maxHeight * 0.02),

                          /// ---------------------------------------------------------
                          /// TRANSLATION BOX - FIXED STYLING
                          /// ---------------------------------------------------------
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(constraints.maxWidth > 600 ? 4 : 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// TITLE
                                  Text(
                                    "Translation",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: constraints.maxWidth > 600 ? 18 : 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                            
                                  SizedBox(height: constraints.maxHeight * 0.015),
                            
                                  /// ---------------------------------------------------------
                                  /// MARSHALLESE BOX
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
                                      padding: EdgeInsets.all(constraints.maxWidth > 600 ? 16 : 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 1,
                                            width: double.infinity,
                                            color: Colors.white.withOpacity(0.5),
                                          ),
                                          SizedBox(height: constraints.maxHeight * 0.012),
                                          Text(
                                            "Marshallese",
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.8),
                                              fontSize: constraints.maxWidth > 600 ? 15 : 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: constraints.maxHeight * 0.008),
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
                            
                                  SizedBox(height: constraints.maxHeight * 0.02),
                            
                                  /// ---------------------------------------------------------
                                  /// CONTEXT BOX
                                  /// ---------------------------------------------------------
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.13),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(constraints.maxWidth > 600 ? 16 : 12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Context",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: constraints.maxWidth > 600 ? 17 : 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: constraints.maxWidth > 600 ? 10 : 8,
                                                    vertical: constraints.maxWidth > 600 ? 6 : 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(6),
                                                    border: Border.all(
                                                      color: Colors.white.withOpacity(0.2),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Body Parts",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: constraints.maxWidth > 600 ? 14 : 13,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                            
                                            SizedBox(height: constraints.maxHeight * 0.015),
                            
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Text(
                                                  "The human body is a complex and fascinating system made up of billions of cells working together to sustain life. It consists of several major systems, including the skeletal, muscular, circulatory, respiratory, digestive, nervous, and reproductive systems - each performing specific functions essential for survival.",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: constraints.maxWidth > 600 ? 15 : 14,
                                                    height: 1.4,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}