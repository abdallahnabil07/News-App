import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/gen/assets.gen.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/model/category_data.dart';

class CategoryContainerCustom extends StatelessWidget {
  final CategoryData categoryData;
  final bool isLeft;
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
          child: Directionality(
            textDirection: isLeft ? TextDirection.rtl : TextDirection.ltr,
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  child: Container(
                    height: context.height * 0.057,
                    width: context.width * 0.4,
                    decoration: BoxDecoration(
                      color: context.isDark ? Colors.black45 : Colors.white60,
                      borderRadius: BorderRadius.circular(84),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: context.isDark
                              ? AppColors.blackColor
                              : AppColors.primaryColorLight,
                          radius: 27,
                          child: isLeft
                              ? Assets.icons.arrowRight.svg(
                                  width: context.paddingWidth24,
                                  height: context.paddingHeight24,
                                  colorFilter: ColorFilter.mode(
                                    context.isDark
                                        ? AppColors.primaryColorLight
                                        : AppColors.primaryColorDark,
                                    BlendMode.srcIn,
                                  ),
                                )
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

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.paddingWidth10,
                          ),
                          child: Text(
                            "View All",
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
