
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import '../models/notification.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserController extends GetxController {
  final userInfo = Rxn<User>();
  final api = ApiService();
  final RxnString privacyPolicy = RxnString();
  final RxList<Notification> notifications = RxList();
  final RxInt unreadNotifications = RxInt(0);
  final notificationRefreshTime = Duration(minutes: 10);
  final RxMap<String, String?> settingsInfo = RxMap();

  RxBool isLoading = RxBool(false);
  RxBool isPasswordShow = RxBool(false);
  Timer? _notificationTimer;


  void togglePasswordVisibility() {
    isPasswordShow.value = !isPasswordShow.value;
  }

  Future<String> getInfo() async {
    isLoading.value = true;
    try {
      final response = await api.get(
        "/api/v1/auth/user_profile/",
        authReq: true,
      );
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setInfo(body['data']);

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error";
    } finally {
      isLoading.value = false;
    }
  }

  void setInfo(Map<String, dynamic>? json) {
    if (json != null) {
      userInfo.value = User.fromJson(json);
    }

    if (_notificationTimer == null) {
      _startNotificationTimer();
    }
  }

  Future<String> updateInfo(Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final response = await api.patch(
        "/api/v1/auth/user_profile/",
        data,
        authReq: true,
      );

      if (response.statusCode == 200) {
        setInfo(jsonDecode(response.body)['data']);
        return "success";
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error";
    } finally {
      isLoading(false);
    }
  }

  Future<String> changePassword(
    String oldPass,
    String newPass,
    String conPass,
  ) async {
    isLoading.value = true;
    try {
      final response = await api.post("/api-auth/change_password/", {
        "old_password": oldPass,
        "new_password": newPass,
        "confirm_password": conPass,
      }, authReq: true);

      if (response.statusCode == 200) {
        isLoading.value = false;
        return "success";
      } else {
        isLoading.value = false;
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      isLoading.value = false;
      return "Unexpected error";
    }
  }

  String? getImageUrl() {
    if (userInfo.value == null || userInfo.value!.image == null) {
      return null;
    }

    String baseUrl = api.baseUrl;

    return baseUrl + userInfo.value!.image!;
  }

  Future<String> _getNotifications() async {
    try {
      final response = await api.get(
        "/api/v1/notifications/all_notifications/",
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        notifications.clear();
        int count = 0;

        final data = body['data'];

        for (var i in data) {
          if (!i["is_read"]) {
            count++;
          }
          notifications.add(Notification.fromJson(i));
        }

        unreadNotifications.value = count;

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error";
    }
  }

  Future<String> readNotifications({String? id}) async {
    try {
      final response = await api.get(
        id != null
            ? "/api/v1/notifications/read/$id/"
            : "/api/v1/notifications/read_all/",
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (id == null) {
          unreadNotifications.value = 0;
          for (var i in notifications) {
            i.isRead = true;
          }
        } else {
          unreadNotifications.value = max(unreadNotifications.value - 1, 0);
          for (var i in notifications) {
            if (i.id.toString() == id) {
              i.isRead = false;
            }
          }
        }
        update();

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error";
    }
  }

  void _startNotificationTimer() {
    _notificationTimer?.cancel();

    _notificationTimer = Timer.periodic(notificationRefreshTime, (timer) {
      _getNotifications();
    });
  }

  void _stopNotificationTimer() {
    _notificationTimer?.cancel();
    _notificationTimer = null;
  }

  Future<String> refreshNotifications() async {
    _stopNotificationTimer();
    final result = await _getNotifications();
    _startNotificationTimer();
    return result;
  }

  @override
  void onClose() {
    _stopNotificationTimer();
    super.onClose();
  }
}
