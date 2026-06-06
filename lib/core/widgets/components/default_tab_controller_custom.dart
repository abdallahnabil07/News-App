import 'package:flutter/material.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/features/news/data/data_sources/models/category_data.dart';
import 'package:news/features/news/data/data_sources/models/source_data_model.dart';

/// Custom TabBar controller for displaying news sources.
///
/// Responsible for:
/// - Rendering a horizontal scrollable TabBar
/// - Displaying source names as tabs
/// - Handling tab selection changes
/// - Highlighting the currently selected tab
class CustomDefaultTabController extends StatefulWidget {
  /// Selected category (used for context in parent UI)
  final CategoryData categoryData;

  /// List of news sources to display as tabs
  final List<SourceData> sourceDataList;

  /// Currently selected tab index
  int currentIndex;

  /// Callback triggered when user selects a tab
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

      /// Disable default splash effect for cleaner UI feel
      child: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
        ),

        /// ---------------- TAB BAR ----------------
        child: TabBar(
          onTap: widget.onTabChanged,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          dividerColor: Colors.transparent,

          /// Active tab indicator styling
          indicatorColor: context.isDark
              ? AppColors.primaryColorLight
              : AppColors.primaryColorDark,
          indicatorSize: TabBarIndicatorSize.tab,

          /// Padding around tab bar
          padding: EdgeInsets.symmetric(
            horizontal: context.paddingWidth14,
            vertical: context.paddingHeight14,
          ),

          /// Build tabs dynamically from source list
          tabs: List.generate(widget.sourceDataList.length, (index) {
            final isSelected = widget.currentIndex == index;

            return Text(
              widget.sourceDataList[index].name,
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: isSelected
                    ? context.hg(14)
                    : context.hg(12),
                fontWeight: isSelected
                    ? FontWeight.w700
                    : FontWeight.w500,
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