import 'package:flutter/material.dart';

class CommonPage extends StatelessWidget {
  final Widget child;
  final Widget? floatingBottomNavigationBar; // floating nav
  final bool showAppBar;
  final String text;

  static const Color topColor = Color(0xFFFFCB59);
  static const Color midColor = Color.fromARGB(255, 247, 155, 57);
  static const Color bottomColor = Color(0xFFDA610F);
  static const Color appBarColor = Color(0xFFFFffff);

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
                leadingWidth: 40, // Reduce space between back button and title
                titleSpacing: 0, // Reduce extra spacing before title
                // Removed title text from appbar
                backgroundColor: const Color.fromARGB(211, 255, 202, 89),
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.white),
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
              child: SafeArea(
                child: Column(
                  children: [
                    // AppBar content in main screen
                    if (showAppBar)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            // Back button
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Title - only in main screen
                            Text(
                              text,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    // Original child content
                    Expanded(child: child),
                  ],
                ),
              ),
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