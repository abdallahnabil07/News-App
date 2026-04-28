import 'package:flutter/material.dart';
import 'package:shimmer_flutter/shimmer_flutter.dart';

import '../core/extensions/context_extensions.dart';
import '../core/theme/app_colors.dart';

class ShimmerCustom extends StatelessWidget {
  final bool isTabBar;
  final bool isNews;

  const ShimmerCustom({
    super.key,
    this.isTabBar = false,
    this.isNews = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isNews) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddingWidth10),
        child: ListView.separated(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              width: context.width * 0.94,
              padding: const EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(vertical: context.paddingHeight8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.transparent),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  /// IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Shimmer(
                      height: context.hg(200),
                      width: double.infinity,
                      cornerRadius: 16,
                      baseColor: AppColors.lightGreyColor,
                    ),
                  ),

                  SizedBox(height: context.hg(12),),

                  /// TITLE
                  Shimmer(
                    height: context.hg(16),
                    width: double.infinity,
                    cornerRadius: 8,
                    baseColor: AppColors.lightGreyColor,
                  ),

                  SizedBox(height: context.hg(8),),

                  Shimmer(
                    height: context.hg(16),
                    width: context.width * 0.6,
                    cornerRadius: 8,
                    baseColor: AppColors.lightGreyColor,
                  ),

                  SizedBox(height: context.hg(12),),

                  /// SOURCE + TIME
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer(
                        width: context.wd(80),
                        height: context.hg(12),
                        cornerRadius: 6,
                        baseColor: AppColors.lightGreyColor,
                      ),
                      Shimmer(
                        width: context.wd(60),
                        height: context.hg(12),
                        cornerRadius: 6,
                        baseColor: AppColors.lightGreyColor,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: context.paddingHeight8);
          },
        ),
      );
    }
    else if (isTabBar) {
      return SizedBox(
        height: context.hg(48),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
            horizontal: context.paddingWidth14,
            vertical: context.paddingHeight14,
          ),
          itemBuilder: (_, index) {
            return Container(
              width: context.wd(80),
              height: context.hg(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          },
          separatorBuilder: (_, _) => SizedBox(width: context.wd(12),),
          itemCount: 5,
        ),
      );
    }
    return const SizedBox(); // مهم جداً
  }
}
