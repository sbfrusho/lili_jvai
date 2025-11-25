import 'package:demo/models/lilli_models/notification_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationController extends GetxController {
  RxList<NotificationItem> notifications = <NotificationItem>[
    NotificationItem(text: "An AI-generated translation for ‘blood pressure’ is ready for admin review", time: "10:30 AM", date: DateTime.now()),
    NotificationItem(text: "Version 2.1 now supports voice input for faster English–Marshallese translations!", time: "09:15 AM", date: DateTime.now()),
    NotificationItem(text: "Your submitted query ‘medicine dosage’ has been reviewed and added to the database", time: "07:30 AM", date: DateTime.now()),

    NotificationItem(text: "A new verified translation for ‘fever’ (English → Marshallese) is now available", time: "10:00 PM", date: DateTime.now().subtract(Duration(days: 1))),
    NotificationItem(text: "Your recent query “medicine bottle” couldn’t be found. Our team will review and add it soon", time: "09:30 PM", date: DateTime.now().subtract(Duration(days: 1))),
    NotificationItem(text: "A new verified translation for “headache” has been added to the medical category", time: "08:45 PM", date: DateTime(2025, 11, 14)),
    NotificationItem(text: "App update available", time: "06:10 PM", date: DateTime(2025, 11, 14)),
  ].obs;

  void deleteNotification(NotificationItem item) {
    notifications.remove(item);
  }

  /// Group notifications by label: Today, Yesterday, or date string
  Map<String, List<NotificationItem>> get notificationsByLabel {
    final Map<String, List<NotificationItem>> map = {};
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    for (var n in notifications) {
      String label;
      final nDate = DateTime(n.date.year, n.date.month, n.date.day);
      final tDate = DateTime(today.year, today.month, today.day);
      final yDate = DateTime(yesterday.year, yesterday.month, yesterday.day);

      if (nDate == tDate) {
        label = "Today";
      } else if (nDate == yDate) {
        label = "Yesterday";
      } else {
        label = DateFormat('dd MMM yyyy').format(n.date);
      }

      if (map.containsKey(label)) {
        map[label]!.add(n);
      } else {
        map[label] = [n];
      }
    }
    return map;
  }
}
