import 'package:flutter/material.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';

class BasicSubscription extends StatefulWidget {
  const BasicSubscription({super.key});

  @override
  State<BasicSubscription> createState() => _BasicSubscriptionState();
}

class _BasicSubscriptionState extends State<BasicSubscription> {
  bool isBasic = true; // true for Basic, false for Premium
  bool isMonthly = true; // true for Monthly, false for Yearly

  @override
  Widget build(BuildContext context) {
    return CommonPage(
      text: "Manage Subscription",
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth > 600 ? 32 : 20,
              vertical: 16,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(constraints.maxWidth > 600 ? 24 : 20),
                child: Column(
                  children: [
                    /// ---------------------------------------------------------
                    /// SUBSCRIPTION TYPE SELECTOR (Basic / Premium)
                    /// ---------------------------------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isBasic = true;
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Basic",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: constraints.maxWidth > 600 ? 18 : 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: 2,
                                width: 50,
                                color: isBasic ? Colors.white : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: constraints.maxWidth > 600 ? 40 : 30),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isBasic = false;
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Premium",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: constraints.maxWidth > 600 ? 18 : 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: 2,
                                width: 70,
                                color: !isBasic ? Colors.white : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: constraints.maxHeight * 0.03),

                    /// ---------------------------------------------------------
                    /// PRICING CARDS (Monthly and Yearly in Column)
                    /// ---------------------------------------------------------
                    Column(
                      children: [
                        /// MONTHLY CARD
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isMonthly = true;
                            });
                          },
                          child: Container(
                            width: constraints.maxWidth > 600 ? 500 : double.infinity,
                            decoration: BoxDecoration(
                              color: isMonthly
                                  ? Colors.white.withOpacity(0.15)
                                  : Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: isMonthly ? 2 : 1,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth > 600 ? 20 : 16,
                                vertical: constraints.maxWidth > 600 ? 20 : 16,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Monthly",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "\$9.99",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "/mo",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: constraints.maxWidth > 600 ? 16 : 12),

                        /// YEARLY CARD
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isMonthly = false;
                            });
                          },
                          child: Container(
                            width: constraints.maxWidth > 600 ? 500 : double.infinity,
                            decoration: BoxDecoration(
                              color: !isMonthly
                                  ? Colors.white.withOpacity(0.15)
                                  : Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: !isMonthly ? 2 : 1,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth > 600 ? 20 : 16,
                                vertical: constraints.maxWidth > 600 ? 20 : 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Yearly",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "\$59.99",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "/yr",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      "Just \$4.99 Per month",
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: constraints.maxWidth > 600 ? 12 : 10,
                                        fontWeight: FontWeight.w500,
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

                    SizedBox(height: constraints.maxHeight * 0.03),

                    /// ---------------------------------------------------------
                    /// FEATURES SECTION
                    /// ---------------------------------------------------------
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(constraints.maxWidth > 600 ? 20 : 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Features",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: constraints.maxWidth > 600 ? 20 : 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.02),
                      
                            /// FEATURES LIST
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    _buildFeatureItem(
                                      "No ads",
                                      constraints,
                                      isEnabled: true,
                                    ),
                                    _buildFeatureItem(
                                      "Save unlimited translations",
                                      constraints,
                                      isEnabled: true,
                                    ),
                                    _buildFeatureItem(
                                      "Early access to new features",
                                      constraints,
                                      isEnabled: true,
                                    ),
                                    _buildFeatureItem(
                                      "Access to verified translation database",
                                      constraints,
                                      isEnabled: true,
                                    ),
                                    _buildFeatureItem(
                                      "AI-generated translation suggestions",
                                      constraints,
                                      isEnabled: !isBasic, // Only enabled for Premium
                                    ),
                                    _buildFeatureItem(
                                      "Access send submit translation manually",
                                      constraints,
                                      isEnabled: !isBasic, // Only enabled for Premium
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      
                            SizedBox(height: constraints.maxHeight * 0.02),
                      
                            /// BUY NOW BUTTON
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    // Handle buy now action
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: constraints.maxWidth > 600 ? 16 : 14,
                                    ),
                                    child: Text(
                                      "Buy Now",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: constraints.maxWidth > 600 ? 18 : 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
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
          );
        },
      ),
    );
  }

  Widget _buildFeatureItem(
    String feature,
    BoxConstraints constraints, {
    required bool isEnabled,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.008),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: isEnabled
                ? Colors.white.withOpacity(0.8)
                : Colors.white.withOpacity(0.3),
            size: constraints.maxWidth > 600 ? 20 : 18,
          ),
          SizedBox(width: constraints.maxWidth > 600 ? 12 : 10),
          Expanded(
            child: Text(
              feature,
              style: TextStyle(
                color: isEnabled
                    ? Colors.white.withOpacity(0.9)
                    : Colors.white.withOpacity(0.4),
                fontSize: constraints.maxWidth > 600 ? 16 : 14,
                height: 1.4,
                decoration: isEnabled ? null : TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      ),
    );
  }
}