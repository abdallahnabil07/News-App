import 'package:flutter/material.dart';

import '../core/extensions/context_extensions.dart';
import '../core/theme/app_colors.dart';

enum IconPosition { start, end }

class CustomTextField extends StatefulWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final int? maxLine;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.maxLine = 1,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureTextPassword = true;

  @override
  Widget build(BuildContext context) {
    final fillColor = Colors.transparent;

    final borderColor =
        widget.borderColor ??
        (context.isDark
            ? AppColors.primaryColorLight
            : AppColors.primaryColorDark);

    final focusedBorderColor =
        widget.focusedBorderColor ??
        (context.isDark ? AppColors.lightGreyColor : AppColors.darkGreyColor);

    return TextFormField(
      validator: widget.validator,
      maxLines: widget.maxLine,
      controller: widget.controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,

        prefixIcon: widget.prefixIcon,

        suffixIcon: widget.suffixIcon,

        hintText: widget.hintText,
        hintStyle: context.textTheme.titleMedium!.copyWith(
          color: context.isDark
              ? AppColors.lightGreyColor
              : AppColors.darkGreyColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: focusedBorderColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.redColor, width: 2),
        ),
      ),
    );
  }
}
