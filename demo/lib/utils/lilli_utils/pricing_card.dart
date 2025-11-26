import 'package:demo/controllers/lilli_controllers/subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PricingCard extends StatelessWidget {
  final bool isMonthly;
  final BoxConstraints constraints;

  const PricingCard({
    super.key,
    required this.isMonthly,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();
    
    return GestureDetector(
      onTap: () => controller.toggleBillingType(isMonthly),
      child: Container(
        width: double.infinity, // Full width
        decoration: BoxDecoration(
          color: _getCardColor(controller),
          borderRadius: BorderRadius.circular(12), // Slightly smaller radius
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: _getBorderWidth(controller),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth > 600 ? 16 : 12, // Reduced padding
            vertical: constraints.maxWidth > 600 ? 16 : 12, // Reduced padding
          ),
          child: _buildCardContent(),
        ),
      ),
    );
  }

  Color _getCardColor(SubscriptionController controller) {
    final bool isSelected = isMonthly ? controller.isMonthly.value : !controller.isMonthly.value;
    return isSelected ? Colors.white.withOpacity(0.15) : Colors.white.withOpacity(0.08);
  }

  double _getBorderWidth(SubscriptionController controller) {
    final bool isSelected = isMonthly ? controller.isMonthly.value : !controller.isMonthly.value;
    return isSelected ? 2 : 1;
  }

  Widget _buildCardContent() {
    if (isMonthly) {
      return _buildMonthlyContent();
    } else {
      return _buildYearlyContent();
    }
  }

  Widget _buildMonthlyContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Monthly",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16, // Smaller font
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            Text(
              "\$9.99",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32, // Smaller font
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "/mo",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14, // Smaller font
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildYearlyContent() {
    return Column(
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
                fontSize: 16, // Smaller font
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Text(
                  "\$59.99",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32, // Smaller font
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "/yr",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14, // Smaller font
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 6), // Reduced spacing
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3), // Reduced padding
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(4), // Smaller radius
          ),
          child: Text(
            "Just \$4.99 Per month",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: constraints.maxWidth > 600 ? 11 : 9, // Smaller font
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}