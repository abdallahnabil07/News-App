import 'package:flutter/material.dart';
import 'package:shimmer_flutter/shimmer_flutter.dart';

import '../core/extensions/context_extensions.dart';
import '../core/theme/app_colors.dart';

class ShimmerCustom extends StatelessWidget {
  const ShimmerCustom({super.key});

  @override
  Widget build(BuildContext context) {
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
                    height: 200,
                    width: double.infinity,
                    cornerRadius: 16,
                    baseColor: AppColors.lightGreyColor,
                  ),
                ),

                const SizedBox(height: 12),

                /// TITLE
                Shimmer(
                  height: 16,
                  width: double.infinity,
                  cornerRadius: 8,
                  baseColor: AppColors.lightGreyColor,
                ),

                const SizedBox(height: 8),

                Shimmer(
                  height: 16,
                  width: context.width * 0.6,
                  cornerRadius: 8,
                  baseColor: AppColors.lightGreyColor,
                ),

                const SizedBox(height: 12),

                /// SOURCE + TIME
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer(
                      width: 80,
                      height: 12,
                      cornerRadius: 6,
                      baseColor: AppColors.lightGreyColor,
                    ),
                    Shimmer(
                      width: 60,
                      height: 12,
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
}
