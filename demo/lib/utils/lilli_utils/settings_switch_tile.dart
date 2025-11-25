import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingsSwitchTile extends StatelessWidget {
  final String icon;
  final String title;
  final RxBool value;
  final Function(bool) onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
          onTap: () => onChanged(!value.value),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 22,
                  height: 22,
                  color: Colors.white,
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),

                /// ---------------- SIMPLE SWITCH ----------------
                /// Grey ball always, white background always
                /// Only the ball moves left/right
                Switch(
                  value: value.value,
                  onChanged: onChanged,

                  /// Thumb (ball) - Always grey
                  activeColor: Colors.grey.shade600,
                  inactiveThumbColor: Colors.grey.shade600,

                  /// Track (background) - Always white
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white,

                  /// Remove border outline
                  trackOutlineColor: WidgetStateProperty.all(Colors.transparent),

                  /// Smooth animation
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )
              ],
            ),
          ),
        ));
  }
}