import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../core/extensions/context_extensions.dart';
import '../core/theme/app_colors.dart';
import '../model/api/articles_data_model.dart';

class ContainerNewsDetails extends StatefulWidget {
  final ArticlesDataModel articlesDataModel;

  const ContainerNewsDetails({super.key, required this.articlesDataModel});

  @override
  State<ContainerNewsDetails> createState() => _ContainerNewsDetailsState();
}

class _ContainerNewsDetailsState extends State<ContainerNewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingWidth10),
      child: Bounceable(
        onTap: () {},
        child: Container(
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
              if (widget.articlesDataModel.urlToImage.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: widget.articlesDataModel.urlToImage,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              //details
              Text(
                textAlign: TextAlign.start,
                widget.articlesDataModel.title,
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
                    widget.articlesDataModel.sourceName,
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.greyColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  //time
                  Text(
                    widget.articlesDataModel.publishedAt,
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
        ),
      ),
    );
  }
}
