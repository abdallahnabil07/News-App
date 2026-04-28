import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/components/custom_elevated_button.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/model/api/articles_data_model.dart';
import 'package:url_launcher/url_launcher.dart';


class BottomSheetCustom extends StatelessWidget {
  final ArticlesDataModel articlesDataModel;

  const BottomSheetCustom({super.key, required this.articlesDataModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingWidth16,
        vertical: context.paddingHeight16,
      ),
      child: Container(
        width: context.width * 0.92,
        height: context.height * 0.43,
        decoration: BoxDecoration(
          color: context.isDark
              ? AppColors.primaryColorLight
              : AppColors.primaryColorDark,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: articlesDataModel.urlToImage,
                      imageBuilder: (context, imageProvider) => Container(
                        height: context.height * 0.23,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => SizedBox(
                        height: context.hg(200),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),

                  SizedBox(height: context.paddingHeight6),
                  Text(
                    textAlign: TextAlign.start,
                    articlesDataModel.description,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontSize: context.hg(14),
                      fontWeight: FontWeight.w500,
                      color: context.isDark
                          ? AppColors.primaryColorDark
                          : AppColors.primaryColorLight,
                    ),
                  ),
                  Spacer(),
                  CustomElevatedButton(
                    textColor: context.isDark
                        ? AppColors.primaryColorLight
                        : AppColors.primaryColorDark,
                    textButton: "View Full Article",
                    onPressed: () async {
                      final Uri uri = Uri.parse(articlesDataModel.url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Cannot open link")),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
