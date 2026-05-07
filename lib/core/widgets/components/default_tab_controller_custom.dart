import 'package:flutter/material.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/features/news/data/data_sources/models/category_data.dart';
import 'package:news/features/news/data/data_sources/models/source_data_model.dart';

class CustomDefaultTabController extends StatefulWidget {
  final CategoryData categoryData;
  final List<SourceData> sourceDataList;
  int currentIndex;
  final ValueChanged<int>? onTabChanged;

  CustomDefaultTabController({
    super.key,
    required this.categoryData,
    required this.sourceDataList,
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  State<CustomDefaultTabController> createState() =>
      _CustomDefaultTabControllerState();
}

class _CustomDefaultTabControllerState
    extends State<CustomDefaultTabController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourceDataList.length,
      child: Theme(
        data: Theme.of(context).copyWith(splashFactory: NoSplash.splashFactory),
        child: TabBar(
          onTap: widget.onTabChanged,
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
          tabs: List.generate(widget.sourceDataList.length, (index) {
            bool isSelected = widget.currentIndex == index;
            return Text(
              widget.sourceDataList[index].name,
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: isSelected ? context.hg(14) : context.hg(12),
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
