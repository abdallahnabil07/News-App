import 'package:flutter/material.dart';
import 'package:news/core/theme/app_colors.dart';

import '../core/extensions/context_extensions.dart';

class CustomDefaultTabController extends StatefulWidget {
  const CustomDefaultTabController({super.key});

  @override
  State<CustomDefaultTabController> createState() =>
      _CustomDefaultTabControllerState();
}

class _CustomDefaultTabControllerState
    extends State<CustomDefaultTabController> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Theme(
        data: Theme.of(context).copyWith(splashFactory: NoSplash.splashFactory),
        child: TabBar(
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          dividerColor: Colors.transparent,
          indicatorColor: context.isDark
              ? AppColors.primaryColorLight
              : AppColors.primaryColorDark,
          indicatorSize: TabBarIndicatorSize.tab,
          padding: EdgeInsets.symmetric(
            horizontal: context.paddingWidth14,
            vertical: context.paddingHeight14,
          ),
          tabs: List.generate(8, (index) {
            bool isSelected = _currentIndex == index;
            return Text(
              "Data",
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: isSelected ? 16 : 14,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: context.isDark
                    ? AppColors.primaryColorLight
                    : AppColors.primaryColorDark,
              ),
            );
          }),
        ),
      ),
    );
  }
}
