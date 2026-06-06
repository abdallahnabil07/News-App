import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:news/core/constants/app_strings.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/gen/assets.gen.dart';
import 'package:news/core/services/bookmark_service.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/core/utils/date_utils_custom.dart';
import 'package:news/core/widgets/components/bottom_sheet_custom.dart';
import 'package:news/features/news/data/data_sources/models/articles_data_model.dart';

/// A news article card widget displayed in the news feed.
///
/// Shows the article image, title, source, date, and a bookmark toggle.
/// Tapping the card opens a bottom sheet with full article details.
///
/// Example:
/// ```dart
/// ContainerNewsDetails(
///   articlesDataModel: article,
///   searchQuery: cubit.searchQuery,
///   onBookmarkRemoved: (url) => _removeBookmark(url),
///   forceBookmarked: true,
/// )
/// ```
class ContainerNewsDetails extends StatefulWidget {
  /// The article data to display.
  final ArticlesDataModel articlesDataModel;

  /// The current search query used to highlight matching text in the title.
  final String searchQuery;

  /// Called when the bookmark is removed — used by BookmarkView to update the list.
  final void Function(String url)? onBookmarkRemoved;

  /// Forces the bookmark icon to appear selected (used in BookmarkView).
  final bool forceBookmarked;

  const ContainerNewsDetails({
    super.key,
    required this.articlesDataModel,
    required this.searchQuery,
    this.onBookmarkRemoved,
    this.forceBookmarked = false,
  });

  @override
  State<ContainerNewsDetails> createState() => _ContainerNewsDetailsState();
}

class _ContainerNewsDetailsState extends State<ContainerNewsDetails> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected =
        widget.forceBookmarked ||
        BookmarkService.isBookmarked(widget.articlesDataModel.url);
  }

  @override
  void didUpdateWidget(ContainerNewsDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    isSelected =
        widget.forceBookmarked ||
        BookmarkService.isBookmarked(widget.articlesDataModel.url);
  }

  @override
  Widget build(BuildContext context) {
    final colorCircularProgressBackground = context.isDark
        ? AppColors.primaryColorLight
        : AppColors.primaryColorDark;
    final colorCircularProgress = context.isDark
        ? AppColors.darkGreyColor
        : AppColors.lightGreyColor;
    final colorSnackBar = context.isDark
        ? AppColors.whiteColorBorder
        : AppColors.blackColor;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingWidth10),
      child: Bounceable(
        // Opens article details bottom sheet
        onTap: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (_) =>
                BottomSheetCustom(articlesDataModel: widget.articlesDataModel),
          );
        },
        child: Container(
          width: context.width * 0.94,
          padding: const EdgeInsets.all(8),
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
            children: <Widget>[
              // Article image with bookmark toggle
              if (widget.articlesDataModel.urlToImage.isNotEmpty)
                Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        height: context.hg(200),
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
                            height: context.hg(200),
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor:
                                    colorCircularProgressBackground,
                                color: colorCircularProgress,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    // Bookmark toggle button
                    Positioned(
                      top: context.hg(8),
                      right: context.wd(8),
                      child: Bounceable(
                        onTap: () {
                          final messenger = ScaffoldMessenger.of(context);
                          setState(() {
                            isSelected = !isSelected;
                            if (isSelected) {
                              BookmarkService.save(widget.articlesDataModel);
                              messenger.showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    AppStrings.savedToBookmarks,
                                    textAlign: TextAlign.center,
                                  ),
                                  duration: const Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: colorSnackBar,
                                ),
                              );
                            } else {
                              BookmarkService.remove(
                                widget.articlesDataModel.url,
                              );
                              widget.onBookmarkRemoved?.call(
                                widget.articlesDataModel.url,
                              );
                              messenger.showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    AppStrings.removedFromBookmarks,
                                    textAlign: TextAlign.center,
                                  ),
                                  duration: const Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: colorSnackBar,
                                ),
                              );
                            }
                          });
                        },
                        child: Assets.images.bookmarkBlack.image(
                          width: context.wd(28),
                          height: context.hg(28),
                          color: isSelected
                              ? AppColors.blackColor
                              : AppColors.whiteColorBorder,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),

              // Article title with search keyword highlight
              TextHighlight(
                text: widget.articlesDataModel.title,
                words: {
                  widget.searchQuery: HighlightedWord(
                    textStyle: TextStyle(
                      backgroundColor: context.isDark
                          ? AppColors.lightGreyColor
                          : AppColors.darkGreyColor,
                      fontWeight: FontWeight.bold,
                      color: context.isDark
                          ? AppColors.primaryColorDark
                          : AppColors.primaryColorLight,
                    ),
                  ),
                },
                textStyle: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: context.hg(16),
                  color: context.isDark
                      ? AppColors.primaryColorLight
                      : AppColors.primaryColorDark,
                ),
              ),
              // Source name and publish date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // by...
                  Text(
                    widget.articlesDataModel.sourceName,
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.greyColor,
                      fontSize: context.hg(12),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // time
                  Text(
                    DateUtilsCustom.formatDate(
                      widget.articlesDataModel.publishedAt,
                    ),
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.greyColor,
                      fontSize: context.hg(12),
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
