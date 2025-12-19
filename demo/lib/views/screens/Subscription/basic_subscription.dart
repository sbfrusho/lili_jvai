// ignore_for_file: deprecated_member_use

import 'package:demo/controllers/lilli_controllers/subscription_controller.dart';
import 'package:demo/utils/lilli_utils/custom_button.dart';
import 'package:demo/utils/lilli_utils/features_list.dart';
import 'package:demo/utils/lilli_utils/pricing_card.dart';
import 'package:demo/utils/lilli_utils/subscription_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';

class BasicSubscription extends StatelessWidget {
  const BasicSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    Get.put(SubscriptionController());
    
    return CommonPage(
      showBackButton: true,
      text: "Manage Subscription",
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth > 600 ? 20 : 12, 
              vertical: 12, 
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(constraints.maxWidth > 600 ? 16 : 12),
                child: Column(
                  children: [
                    SubscriptionTypeSelector(constraints: constraints),
                    SizedBox(height: constraints.maxHeight * 0.02), // Reduced spacing
                    
                    // Pricing Cards
                    Column(
                      children: [
                        PricingCard(isMonthly: true, constraints: constraints),
                        SizedBox(height: constraints.maxWidth > 600 ? 12 : 8), // Reduced spacing
                        PricingCard(isMonthly: false, constraints: constraints),
                      ],
                    ),
                    
                    SizedBox(height: constraints.maxHeight * 0.02), // Reduced spacing
                    
                    // Features Section
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(constraints.maxWidth > 600 ? 12 : 8), // Reduced padding
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Features",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24, // Slightly smaller font
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.015), // Reduced spacing
                            
                            FeaturesList(constraints: constraints),
                            
                            SizedBox(height: constraints.maxHeight * 0.015), // Reduced spacing
                            
                            CustomButton(title: "Buy Now", onTap: (){}, height: 53 ,width: 348,)
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
}