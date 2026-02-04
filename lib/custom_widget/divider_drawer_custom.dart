import 'package:flutter/material.dart';

import '../core/extensions/context_extensions.dart';
import '../core/theme/app_colors.dart';

class DividerDrawerCustom extends StatelessWidget {
  const DividerDrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingWidth16),
      child: Divider(color: AppColors.primaryColorLight, height: 1),
    );
  }
}
