// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CustomButton extends StatelessWidget {
//   final String title;
//   final VoidCallback? onTap;

//   final double borderRadius;
//   final EdgeInsetsGeometry? padding;
//   final Color backgroundColor;
//   final TextStyle? textStyle;

//   final Widget? prefix;
//   final Widget? suffix;
//   final double? width;
//   final double? height;

//   final String? prefixImageAsset;

//   const CustomButton({
//     super.key,
//     required this.title,
//     required this.onTap,
//     this.borderRadius = 12,
//     this.padding,
//     this.backgroundColor = const Color(0x33FFFFFF),
//     this.textStyle,
//     this.prefix,
//     this.suffix,
//     this.width,
//     this.height,
//     this.prefixImageAsset,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // 🟢 If height is given → remove vertical padding completely
//     final EdgeInsetsGeometry finalPadding =
//         height != null ? const EdgeInsets.symmetric(horizontal: 16) : (padding ?? const EdgeInsets.all(16));

//     // Prefix image builder
//     Widget? prefixWidget = prefix;
//     if (prefixImageAsset != null) {
//       prefixWidget = SvgPicture.asset(
//         prefixImageAsset!,
//         width: 20,
//         height: 20,
//       );
//     }

//     return InkWell(
//       borderRadius: BorderRadius.circular(borderRadius),
//       onTap: onTap,
//       child: Container(
//         width: width,
//         height: height,               
//         padding: finalPadding,        
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(borderRadius),
//           border: Border.all(
//             color: Colors.white, // white border
//             width: 0.5,          // 0.5px width
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,  
//           children: [
//             if (prefixWidget != null) ...[
//               prefixWidget,
//               const SizedBox(width: 8),
//             ],
//             Flexible(
//               child: Text(
//                 title,
//                 overflow: TextOverflow.ellipsis,
//                 style: textStyle ??
//                     const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//               ),
//             ),
//             if (suffix != null) ...[
//               const SizedBox(width: 8),
//               suffix!,
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CustomButton extends StatelessWidget {
//   final String title;
//   final VoidCallback? onTap;

//   final double borderRadius;
//   final EdgeInsetsGeometry? padding;
//   final Color? backgroundColor; // ✅ custom color with default
//   final double? backgroundOpacity; // ✅ custom opacity
//   final TextStyle? textStyle;

//   final Widget? prefix;
//   final Widget? suffix;
//   final double? width;
//   final double? height;

//   final String? prefixImageAsset;

//   const CustomButton({
//     super.key,
//     required this.title,
//     required this.onTap,
//     this.borderRadius = 12,
//     this.padding,
//     this.backgroundColor, // optional
//     this.backgroundOpacity, // optional
//     this.textStyle,
//     this.prefix,
//     this.suffix,
//     this.width,
//     this.height,
//     this.prefixImageAsset,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // 🟢 If height is given → remove vertical padding completely
//     final EdgeInsetsGeometry finalPadding =
//         height != null ? const EdgeInsets.symmetric(horizontal: 16) : (padding ?? const EdgeInsets.all(16));

//     // Prefix image builder
//     Widget? prefixWidget = prefix;
//     if (prefixImageAsset != null) {
//       prefixWidget = SvgPicture.asset(
//         prefixImageAsset!,
//         width: 20,
//         height: 20,
//       );
//     }

//     // Determine final background color with opacity
//     final Color finalBgColor = (backgroundColor ?? const Color(0x33FFFFFF))
//         .withOpacity(backgroundOpacity ?? (backgroundColor == null ? 0.2 : 1.0));

//     return InkWell(
//       borderRadius: BorderRadius.circular(borderRadius),
//       onTap: onTap,
//       child: Container(
//         width: width,
//         height: height,
//         padding: finalPadding,
//         decoration: BoxDecoration(
//           color: finalBgColor,
//           borderRadius: BorderRadius.circular(borderRadius),
//           border: Border.all(
//             color: Colors.white, // white border
//             width: 0.5,          // 0.5px width
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             if (prefixWidget != null) ...[
//               prefixWidget,
//               const SizedBox(width: 8),
//             ],
//             Flexible(
//               child: Text(
//                 title,
//                 overflow: TextOverflow.ellipsis,
//                 style: textStyle ??
//                     const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//               ),
//             ),
//             if (suffix != null) ...[
//               const SizedBox(width: 8),
//               suffix!,
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor; // optional color
  final double? backgroundOpacity; // optional opacity
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
    this.backgroundColor,
    this.backgroundOpacity,
    this.textStyle,
    this.prefix,
    this.suffix,
    this.width,
    this.height,
    this.prefixImageAsset,
  });

  @override
  Widget build(BuildContext context) {
    // 🟢 Remove vertical padding if height is given
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

    // Force opacity: either the given value or default 0.2
    final double finalOpacity = backgroundOpacity ?? 0.2;
    final Color finalBgColor = (backgroundColor ?? Colors.white).withOpacity(finalOpacity);

    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: finalPadding,
        decoration: BoxDecoration(
          color: finalBgColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: Colors.white,
            width: 0.5,
          ),
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
