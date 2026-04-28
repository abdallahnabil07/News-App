import 'package:flutter/material.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/theme/app_colors.dart';

class CustomElevatedButton extends StatefulWidget {
  final String textButton;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.textButton,
    this.backgroundColor,
    required this.onPressed,
    this.textColor = AppColors.primaryColorLight,
    this.borderColor,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    final colorElevatedButton = context.isDark
        ? AppColors.primaryColorDark
        : AppColors.primaryColorLight;
    return SizedBox(
      width: context.width * 0.92,
      height: context.height * 0.063,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor ?? colorElevatedButton,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: widget.borderColor ?? Colors.transparent,
              width: 1,
            ),
          ),
        ),
        onPressed: widget.onPressed,

        child: Text(
          textAlign: TextAlign.center,
          widget.textButton,
          style: context.textTheme.titleLarge!.copyWith(
            color: widget.textColor,
            fontWeight: FontWeight.w700,
            fontSize: context.hg(16),
          ),
        ),
      ),
    );
  }
}
