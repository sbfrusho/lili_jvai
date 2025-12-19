import 'package:demo/controllers/lilli_controllers/settings_controller.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custom_button.dart';
import 'package:demo/utils/lilli_utils/settings_option_tile.dart';
import 'package:demo/utils/lilli_utils/settings_switch_tile.dart';
import 'package:demo/views/screens/Subscription/basic_subscription.dart';
import 'package:demo/views/screens/profile/about_us_screen.dart';
import 'package:demo/views/screens/profile/change_password_screen.dart';
import 'package:demo/views/screens/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return CommonPage(
      showAppBar: false,
      showBackButton: true,
      text: "Profile",
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 40),

              // PROFILE IMAGE
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.asset(
                      "assets/icons/person_1.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                "johndoe@email.com",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 12),

              // EDIT PROFILE BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: CustomButton(
                  title: "Edit Profile",
                  onTap: () {
                    Get.to(() => const EditProfileScreen());
                  },
                  width: 143,
                  height: 43,
                  backgroundColor: Colors.white.withOpacity(0.12),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  borderRadius: 12,
                ),
              ),

              const SizedBox(height: 30),

              // SETTINGS BLOCK (flexible scrollable area)
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              // Push Notification
                              SettingsSwitchTile(
                                icon: "assets/icons/settings_notification.svg",
                                title: "Push Notification",
                                value: controller.pushNotification,
                                onChanged: controller.togglePushNotification,
                              ),

                              // Change Password
                              SettingsOptionTile(
                                icon: "assets/icons/settings_lock.svg",
                                title: "Change Password",
                                onTap: () {
                                  Get.to(() => ChangePasswordScreen());
                                },
                              ),

                              // Manage Subscription
                              SettingsOptionTile(
                                icon: "assets/icons/settings_manage_sub.svg",
                                title: "Manage Subscription",
                                onTap: () {Get.to(BasicSubscription());},
                              ),

                              // Terms of Service
                              SettingsOptionTile(
                                icon: "assets/icons/settings_term_services.svg",
                                title: "Terms of Services",
                                onTap: () {},
                              ),

                              // About Us
                              SettingsOptionTile(
                                icon: "assets/icons/settings_about.svg",
                                title: "About Us",
                                onTap: () {
                                  Get.to(() => AboutUsScreen());
                                },
                              ),

                              // Log Out
                              SettingsOptionTile(
                                icon: "assets/icons/settings_log_out.svg",
                                title: "Log Out",
                                onTap: () {
                                  controller.showLogoutPopup();
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),

          // Logout Popup Overlay
          Obx(() {
            if (!controller.isLogoutPopupVisible.value) return const SizedBox.shrink();

            return Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.5),
                child: Center(
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFFCB59),
                          Color(0xFFF6A652),
                          Color(0xFFDA610F),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Are you sure you want to Log Out?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                title: "Yes",
                                onTap: controller.logout,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                textStyle: const TextStyle(color: Colors.white),
                                height: 50,
                                borderRadius: 12,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomButton(
                                title: "No",
                                onTap: controller.hideLogoutPopup,
                                backgroundColor: Colors.white,
                                textStyle: const TextStyle(color: Colors.black),
                                height: 50,
                                borderRadius: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
