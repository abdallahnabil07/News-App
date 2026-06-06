import 'package:flutter/material.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/theme/app_colors.dart';

/// A styled horizontal divider used inside the app drawer.
///
/// Adds horizontal padding to match the drawer's content alignment.
class DividerDrawerCustom extends StatelessWidget {
  const DividerDrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingWidth16),
      child: const Divider(color: AppColors.primaryColorLight, height: 1),
    );
  }
}
