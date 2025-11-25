import 'package:demo/controllers/lilli_controllers/notification_controller.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return CommonPage(
      showAppBar: true,
      text: "Notifications",
      child: Obx(() {
        final grouped = controller.notificationsByLabel;

        if (grouped.isEmpty) {
          return const Center(
            child: Text(
              "No notifications",
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return ListView(
          padding: EdgeInsets.zero, // remove extra padding
          children: grouped.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    entry.key,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Notification items
                Column(
                  children: entry.value.map((n) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                      child: NotificationCard(
                        text: n.text,
                        time: n.time,
                        onDelete: () => controller.deleteNotification(n),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          }).toList(),
        );
      }),
    );
  }
}
