import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFieldAuth extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool isPassword;
  final IconData? prefixIcon;
  final String? prefixSvg;
  final double? width;
  final double? height;
  final int? radius;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final TextAlignVertical? textAlignVertical;
  final FocusNode? focusNode;

  const CustomTextFieldAuth({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.prefixSvg,
    this.width,
    this.height,
    this.radius,
    this.onTap,
    this.onChanged,
    this.maxLines = 1,
    this.textAlignVertical,
    this.focusNode,
  });

  @override
  State<CustomTextFieldAuth> createState() => _CustomTextFieldAuthState();
}

class _CustomTextFieldAuthState extends State<CustomTextFieldAuth> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    Widget? buildIcon() {
      if (widget.prefixIcon != null) {
        return Icon(
          widget.prefixIcon,
          color: Colors.white,
          size: 22,
        );
      } else if (widget.prefixSvg != null) {
        return SvgPicture.asset(
          widget.prefixSvg!,
          width: 20,
          height: 20,
          color: Colors.white,
          fit: BoxFit.contain,
        );
      }
      return null;
    }

    // Align text to top for multi-line, center for single-line
    final verticalAlign = widget.maxLines != null && widget.maxLines! > 1
        ? TextAlignVertical.top
        : (widget.textAlignVertical ?? TextAlignVertical.center);

    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(widget.radius?.toDouble() ?? 12),
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.prefixIcon != null || widget.prefixSvg != null) ...[
            buildIcon()!,
            const SizedBox(width: 6),
          ],
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              onTap: widget.onTap,
              onChanged: widget.onChanged,
              obscureText: widget.isPassword ? _obscureText : false,
              maxLines: widget.maxLines,
              textAlignVertical: verticalAlign,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: widget.hint ?? widget.label,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isCollapsed: true, // keeps icon and text aligned
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (widget.isPassword)
            IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
        ],
      ),
    );
  }
}
