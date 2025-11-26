import 'package:demo/controllers/lilli_controllers/subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeaturesList extends StatelessWidget {
  final BoxConstraints constraints;

  const FeaturesList({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();
    
    return Expanded(
      child: SingleChildScrollView(
        child: Obx(() => Column(
          children: [
            _buildFeatureItem("No ads", true),
            _buildFeatureItem("Save unlimited translations", true),
            _buildFeatureItem("Early access to new features", true),
            _buildFeatureItem("Access to verified translation database", true),
            _buildFeatureItem("AI-generated translation suggestions", !controller.isBasic.value),
            _buildFeatureItem("Access send submit translation manually", !controller.isBasic.value),
          ],
        )),
      ),
    );
  }

  Widget _buildFeatureItem(String feature, bool isEnabled) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.006),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: isEnabled ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.3),
            size: constraints.maxWidth > 600 ? 18 : 16,
          ),
          SizedBox(width: constraints.maxWidth > 600 ? 10 : 8),
          Expanded(
            child: Text(
              feature,
              style: TextStyle(
                color: isEnabled ? Colors.white.withOpacity(0.9) : Colors.white.withOpacity(0.4),
                fontSize: constraints.maxWidth > 600 ? 16 : 14 ,
                height: 1.4,
                // Removed TextDecoration.lineThrough
              ),
            ),
          ),
        ],
      ),
    );
  }
}