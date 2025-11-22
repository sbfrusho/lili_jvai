import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final TextStyle? textStyle;

  final Widget? prefix;
  final Widget? suffix;
  final double? width;
  final double? height;

  final String? prefixImageAsset;

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.borderRadius = 12,
    this.padding,
    this.backgroundColor = const Color(0x33FFFFFF),
    this.textStyle,
    this.prefix,
    this.suffix,
    this.width,
    this.height,
    this.prefixImageAsset,
  });

  @override
  Widget build(BuildContext context) {

    // 🟢 If height is given → remove vertical padding completely
    final EdgeInsetsGeometry finalPadding =
        height != null ? const EdgeInsets.symmetric(horizontal: 16) : (padding ?? const EdgeInsets.all(16));

    // Prefix image builder
    Widget? prefixWidget = prefix;
    if (prefixImageAsset != null) {
      prefixWidget = SvgPicture.asset(
        prefixImageAsset!,
        width: 20,
        height: 20,
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onTap,
      child: Container(
        width: width,
        height: height,               // fixed height works now
        padding: finalPadding,        // 🔥 NO vertical padding
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,  
          children: [
            if (prefixWidget != null) ...[
              prefixWidget,
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: textStyle ??
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            if (suffix != null) ...[
              const SizedBox(width: 8),
              suffix!,
            ],
          ],
        ),
      ),
    );
  }
}
