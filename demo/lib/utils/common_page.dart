import 'package:flutter/material.dart';

class CommonPage extends StatelessWidget {
  final Widget child;
  final Widget? bottonNavigationBar;
  final bool showAppBar;
  final String text;

  static const Color topColor = Color(0xFFFFCB59);
  static const Color midColor = Color.fromARGB(255, 247, 155, 57);
  static const Color bottomColor = Color(0xFFDA610F);

  const CommonPage({
    super.key,
    required this.child,
    this.bottonNavigationBar,
    this.showAppBar = true,
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
        backgroundColor: CommonPage.topColor, // use the static field correctly
        elevation: 0,
      ),
      body: Container(
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
    );
  }
}
