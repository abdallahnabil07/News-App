import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news/core/constants/app_strings.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/gen/assets.gen.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/features/news/data/data_sources/models/category_data.dart';

/// A category card widget displayed on the Home screen.
///
/// Displays a category image with its name and a "View All" button.
/// Alternates layout direction based on [isLeft] for visual variety.
///
/// Example:
/// ```dart
/// CategoryContainerCustom(
///   categoryData: category,
///   isLeft: index % 2 == 0,
///   onTab: (category) => cubit.selectCategory(category),
/// )
/// ```
class CategoryContainerCustom extends StatelessWidget {
  /// The category data to display (name, image, id).
  final CategoryData categoryData;

  /// If true, the button appears on the right side; otherwise on the left.
  final bool isLeft;

  /// Called when the user taps the "View All" button.
  final Function(CategoryData) onTab;

  const CategoryContainerCustom({
    super.key,
    required this.categoryData,
    required this.isLeft,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingHeight14,
        vertical: context.paddingHeight8,
      ),

      //Image category & category name
      child: Container(
        width: double.infinity,
        height: context.hg(198),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(
              context.isDark
                  ? categoryData.imageDarkMode
                  : categoryData.imageLightMode,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingWidth16),
          // Direction flips based on isLeft to create alternating card layout
          child: Directionality(
            textDirection: isLeft ? TextDirection.rtl : TextDirection.ltr,
            child: Column(
              spacing: context.hg(20),
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Category name
                Text(
                  categoryData.name,
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontSize: context.hg(34),
                    fontWeight: FontWeight.w400,
                    color: context.isDark
                        ? AppColors.primaryColorDark
                        : AppColors.primaryColorLight,
                  ),
                ),

                Bounceable(
                  onTap: () {
                    onTab(categoryData);
                  },
                  //view all word with arrows
                  child: Container(
                    height: context.hg(60),
                    width: context.width * 0.4,
                    decoration: BoxDecoration(
                      color: context.isDark ? Colors.black45 : Colors.white60,
                      borderRadius: BorderRadius.circular(84),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: context.isDark
                              ? AppColors.blackColor
                              : AppColors.primaryColorLight,
                          radius: 27,
                          //arrowRight
                          child: isLeft
                              ? Assets.icons.arrowRight.svg(
                                  width: context.wd(24),
                                  height: context.hg(24),
                                  colorFilter: ColorFilter.mode(
                                    context.isDark
                                        ? AppColors.primaryColorLight
                                        : AppColors.primaryColorDark,
                                    BlendMode.srcIn,
                                  ),
                                )
                              //arrowLeft
                              : Assets.icons.arrowLeft.svg(
                                  width: context.paddingWidth30,
                                  height: context.paddingHeight30,
                                  colorFilter: ColorFilter.mode(
                                    context.isDark
                                        ? AppColors.primaryColorLight
                                        : AppColors.primaryColorDark,
                                    BlendMode.srcIn,
                                  ),
                                ),
                        ),
                        //view all word
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.paddingWidth10,
                          ),
                          child: Text(
                            AppStrings.viewAll,
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: context.isDark
                                  ? AppColors.primaryColorLight
                                  : AppColors.primaryColorDark,
                              fontSize: context.hg(20),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
