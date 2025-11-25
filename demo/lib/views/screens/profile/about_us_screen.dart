import 'package:flutter/material.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPage(
      text: "About Us",
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo just below AppBar
            Image.asset(
              "assets/icons/1.png",
              width: 64,
              height: 40,
            ),

            const SizedBox(height: 24),

            const Text(
              "Our app is designed to bridge the communication gap between English and Marshallese speakers. "
              "With a focus on both medical and everyday language, it provides fast, accurate, and user-friendly translations "
              "that help users understand and express themselves clearly. By combining a verified translation database with "
              "advanced AI suggestions, the platform ensures reliability and continuous improvement. Whether for healthcare professionals, "
              "students, or daily conversations, our goal is to make bilingual communication effortless and accessible to everyone "
              "while preserving the richness of the Marshallese language.",
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
