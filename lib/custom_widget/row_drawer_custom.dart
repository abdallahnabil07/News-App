import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../core/extensions/context_extensions.dart';
import '../core/gen/assets.gen.dart';
import '../core/theme/app_colors.dart';

class RowDrawerCustom extends StatelessWidget {
  final SvgGenImage icon;
  final String text;
  final VoidCallback? onTap;

  const RowDrawerCustom({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: Bounceable(
        onTap: onTap,
        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon.svg(),
            Text(
              text,
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.primaryColorLight,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
