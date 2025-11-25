import 'package:flutter/material.dart';

class CommonPage extends StatelessWidget {
  final Widget child;
  final Widget? floatingBottomNavigationBar; // floating nav
  final bool showAppBar;
  final String text;

  static const Color topColor = Color(0xFFFFCB59);
  static const Color midColor = Color.fromARGB(255, 247, 155, 57);
  static const Color bottomColor = Color(0xFFDA610F);

  const CommonPage({
    super.key,
    required this.child,
    this.floatingBottomNavigationBar,
    this.showAppBar = true,
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: showAppBar
            ? AppBar(
                title: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: topColor,
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.white), // ✅ back button color white
              )
            : null,
        body: Stack(
          children: [
            // Main content
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [topColor, midColor, bottomColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(child: child),
            ),
      
            // Floating Bottom Navigation Bar
            if (floatingBottomNavigationBar != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 16, // distance from bottom
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: floatingBottomNavigationBar!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
