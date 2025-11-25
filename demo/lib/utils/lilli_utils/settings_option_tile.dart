import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsOptionTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const SettingsOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}
