import 'package:flutter/material.dart';

class BuyNowButton extends StatelessWidget {
  final BoxConstraints constraints;
  final VoidCallback onPressed;

  const BuyNowButton({
    super.key,
    required this.constraints,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Full width
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10), // Smaller radius
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10), // Smaller radius
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: constraints.maxWidth > 600 ? 14 : 12, // Reduced padding
            ),
            child: Text(
              "Buy Now",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: constraints.maxWidth > 600 ? 16 : 14, // Smaller font
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}