import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/core/constants/app_strings.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/features/news/data/data_sources/models/articles_data_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_elevated_button.dart';

/// Bottom sheet widget that shows a preview of a news article.
///
/// Responsible for:
/// - Displaying article image
/// - Showing article description
/// - Providing a button to open full article in browser
class BottomSheetCustom extends StatelessWidget {
  /// Article data used to populate the bottom sheet UI
  final ArticlesDataModel articlesDataModel;

  const BottomSheetCustom({
    super.key,
    required this.articlesDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingWidth16,
        vertical: context.paddingHeight16,
      ),

      /// Main container styling for bottom sheet
      child: Container(
        width: context.width * 0.92,
        height: context.height * 0.43,
        decoration: BoxDecoration(
          color: context.isDark
              ? AppColors.primaryColorLight
              : AppColors.primaryColorDark,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),

        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),

            /// Column layout: image → description → button
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                /// ---------------- ARTICLE IMAGE ----------------
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: articlesDataModel.urlToImage,

                    imageBuilder: (context, imageProvider) =>
                        Container(
                          height: context.height * 0.23,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                    /// Loading state for image
                    placeholder: (context, url) =>
                        SizedBox(
                          height: context.hg(200),
                          child: const Center(
                            child: CircularProgressIndicator(),
                      ),
                        ),

                    /// Error state if image fails to load
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),

                SizedBox(height: context.paddingHeight6),

                /// ---------------- ARTICLE DESCRIPTION ----------------
                Text(
                  articlesDataModel.description,
                  textAlign: TextAlign.start,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontSize: context.hg(14),
                    fontWeight: FontWeight.w500,
                    color: context.isDark
                        ? AppColors.primaryColorDark
                        : AppColors.primaryColorLight,
                  ),
                ),

                const Spacer(),

                /// ---------------- VIEW FULL ARTICLE BUTTON ----------------
                CustomElevatedButton(
                  textColor: context.isDark
                      ? AppColors.primaryColorLight
                      : AppColors.primaryColorDark,
                  textButton: AppStrings.viewFullArticle,
                  onPressed: () async {
                    final Uri uri = Uri.parse(articlesDataModel.url);

                    if (await canLaunchUrl(uri)) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.inAppBrowserView,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(AppStrings.cannotOpenLink),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}