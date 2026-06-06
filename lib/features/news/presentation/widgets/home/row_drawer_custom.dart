import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/gen/assets.gen.dart';
import 'package:news/core/theme/app_colors.dart';

/// A single row item used inside the app drawer.
///
/// Supports both SVG and PNG icons, with an optional tap callback.
/// Used for navigation items like "Go To Home" and "Bookmarks".
///
/// Example:
/// ```dart
/// RowDrawerCustom(
///   icon: Assets.icons.homeIcon,
///   text: AppStrings.goToHome,
///   onTap: () => Navigator.pop(context),
/// )
/// ```
class RowDrawerCustom extends StatelessWidget {
  /// SVG icon to display (optional).
  final SvgGenImage? icon;

  /// PNG icon to display if no SVG is provided (optional).
  final AssetGenImage? pngIcon;

  /// Size of the icon (optional).
  final double? iconSize;

  /// The label text displayed next to the icon.
  final String text;

  /// Called when the row is tapped (optional).
  final VoidCallback? onTap;

  const RowDrawerCustom({
    super.key,
    this.icon,
    required this.text,
    this.onTap,
    this.pngIcon,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Bounceable(
        onTap: onTap,
        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // SVG icon takes priority over PNG
            if (icon != null)
              icon!.svg(width: iconSize, height: iconSize)
            else
              if (pngIcon != null)
                pngIcon!.image(width: iconSize,
                    height: iconSize,
                    color: AppColors.whiteColorBorder),
            Text(
              text,
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.primaryColorLight,
                fontSize: context.hg(20),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
