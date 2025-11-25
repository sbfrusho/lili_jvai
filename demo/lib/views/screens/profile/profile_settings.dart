import 'package:demo/controllers/lilli_controllers/settings_controller.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custon_bottom_navbar.dart';
import 'package:demo/utils/lilli_utils/custom_button.dart';
import 'package:demo/utils/lilli_utils/settings_option_tile.dart';
import 'package:demo/utils/lilli_utils/settings_switch_tile.dart';
import 'package:demo/views/screens/profile/about_us_screen.dart';
import 'package:demo/views/screens/profile/change_password_screen.dart';
import 'package:demo/views/screens/profile/edit_profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return CommonPage(
      child: Stack(
        children: [
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavBar(),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              children: [
                const SizedBox(height: 40),

                /// PROFILE IMAGE
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

                /// EDIT BUTTON - Using CustomButton
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: CustomButton(
                    title: "Edit Profile",
                    onTap: () {
                      Get.to(() => const EditProfileScreen());
                    },
                    width: 143   ,
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

                /// SETTINGS BLOCK
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      /// 1. Push Notification (GetX powered)
                      SettingsSwitchTile(
                        icon: "assets/icons/settings_notification.svg",
                        title: "Push Notification",
                        value: controller.pushNotification,
                        onChanged: controller.togglePushNotification,
                      ),

                      SettingsOptionTile(
                        icon: "assets/icons/settings_lock.svg",
                        title: "Change Password",
                        onTap: () {Get.to(ChangePasswordScreen());},
                      ),

                      SettingsOptionTile(
                        icon: "assets/icons/settings_manage_sub.svg",
                        title: "Manage Subscription",
                        onTap: () {},
                      ),

                      SettingsOptionTile(
                        icon: "assets/icons/settings_term_services.svg",
                        title: "Terms of Services",
                        onTap: () {},
                      ),

                      SettingsOptionTile(
                        icon: "assets/icons/settings_about.svg",
                        title: "About Us",
                        onTap: () {Get.to(AboutUsScreen());},
                      ),

                      SettingsOptionTile(
                        icon: "assets/icons/settings_log_out.svg",
                        title: "Log Out",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 160),
              ],
            ),
          ),
        ],
      ),
    );
  }
}