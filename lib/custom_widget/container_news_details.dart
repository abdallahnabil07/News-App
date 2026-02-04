import 'package:flutter/material.dart';

import '../core/extensions/context_extensions.dart';
import '../core/gen/assets.gen.dart';
import '../core/theme/app_colors.dart';

class ContainerNewsDetails extends StatefulWidget {
  const ContainerNewsDetails({super.key});

  @override
  State<ContainerNewsDetails> createState() => _ContainerNewsDetailsState();
}

class _ContainerNewsDetailsState extends State<ContainerNewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.94,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: context.paddingHeight8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.isDark
              ? AppColors.primaryColorLight
              : AppColors.primaryColorDark,
        ),
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Assets.images.oldMan.image(width: double.infinity),
          ),
          //details
          Text(
            textAlign: TextAlign.start,
            "40-year-old man falls 200 feet to his death while canyoneering at national park",
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: context.isDark
                  ? AppColors.primaryColorLight
                  : AppColors.primaryColorDark,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //by...
              Text(
                "By : Jon Haworth",
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.greyColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              //time
              Text(
                "15 minutes ago",
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.greyColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
