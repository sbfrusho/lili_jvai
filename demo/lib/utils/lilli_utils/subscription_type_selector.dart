import 'package:demo/controllers/lilli_controllers/subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SubscriptionTypeSelector extends StatelessWidget {
  final BoxConstraints constraints;

  const SubscriptionTypeSelector({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildTypeOption("Basic", true, controller, constraints),
        SizedBox(width: constraints.maxWidth > 600 ? 30 : 20), // Reduced spacing
        _buildTypeOption("Premium", false, controller, constraints),
      ],
    );
  }

  Widget _buildTypeOption(String title, bool isBasicType, SubscriptionController controller, BoxConstraints constraints) {
    return InkWell(
      onTap: () => controller.toggleSubscriptionType(isBasicType),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: constraints.maxWidth > 600 ? 16 : 14, // Smaller font
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2), // Reduced spacing
          Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 2,
            width: title == "Basic" ? 40 : 60, // Reduced width
            color: controller.isBasic.value == isBasicType ? Colors.white : Colors.transparent,
          )),
        ],
      ),
    );
  }
}