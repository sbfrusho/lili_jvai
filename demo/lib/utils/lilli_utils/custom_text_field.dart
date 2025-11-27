import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatefulWidget {
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

  const CustomTextField({
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
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    Widget? buildPrefix() {
      if (widget.prefixIcon != null) {
        return Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          child: Icon(
            widget.prefixIcon,
            color: Colors.white,
            size: 22,
          ),
        );
      } else if (widget.prefixSvg != null) {
        return Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          child: SvgPicture.asset(
            widget.prefixSvg!,
            width: 20,
            height: 20,
            color: Colors.white,
            fit: BoxFit.contain,
          ),
        );
      }
      return null;
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration( 
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(widget.radius?.toDouble() ?? 12),
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 0.5),
      ),
      child: TextField(
        controller: widget.controller,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        obscureText: widget.isPassword ? _obscureText : false,
        maxLines: widget.maxLines,
        textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: widget.label,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 15,
          ),
          prefixIcon: buildPrefix(),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 48,
            minHeight: 48,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: widget.maxLines != null && widget.maxLines! > 1 ? 14 : 16,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}