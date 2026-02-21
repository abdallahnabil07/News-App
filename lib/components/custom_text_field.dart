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
  final double? width;
  final double? height;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;

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
    this.width,
    this.height,
    this.onChanged,
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

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        onChanged: widget.onChanged,
        validator: widget.validator,
        maxLines: widget.maxLine,
        controller: widget.controller,
        keyboardType: TextInputType.text,
        style: context.textTheme.titleMedium!.copyWith(
          color: context.isDark
              ? AppColors.lightGreyColor
              : AppColors.darkGreyColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          prefixIcon: widget.prefixIcon,
          prefixIconConstraints: BoxConstraints(
            minWidth: 34,
            minHeight: 34,
            maxWidth: 40,
            maxHeight: 40,
          ),
          suffixIcon: widget.suffixIcon,
          suffixIconConstraints: BoxConstraints(
            minWidth: 24,
            minHeight: 24,
            maxWidth: 34,
            maxHeight: 34,
          ),
          hintText: widget.hintText,
          hintStyle: context.textTheme.titleMedium!.copyWith(
            color: context.isDark
                ? AppColors.lightGreyColor
                : AppColors.darkGreyColor,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: focusedBorderColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.redColor, width: 1),
          ),
        ),
      ),
    );
  }
}
