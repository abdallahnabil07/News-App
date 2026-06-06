import 'package:flutter/material.dart';
import 'package:news/core/constants/app_strings.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/services/bookmark_service.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/features/news/data/data_sources/models/articles_data_model.dart';
import 'package:news/features/news/presentation/widgets/news/container_news_details.dart';

/// Bookmark screen that displays saved news articles.
///
/// Responsible for:
/// - Loading all bookmarked articles from [BookmarkService]
/// - Displaying bookmarked news in a list
/// - Handling removal of bookmarks
/// - Showing empty state when no bookmarks exist
class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  /// List of saved bookmarked articles
  late List<ArticlesDataModel> bookmarks;

  @override
  void initState() {
    super.initState();

    // Load all saved bookmarks when screen initializes
    bookmarks = BookmarkService.getAll();
  }

  /// Removes a bookmark from both storage and UI state
  void _removeBookmark(String url) {
    BookmarkService.remove(url);
    setState(() {
      bookmarks.removeWhere((a) => a.url == url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// ---------------- APP BAR ----------------
      /// Simple title for bookmarks screen
      appBar: AppBar(
        title: const Text(AppStrings.bookmarks),
        automaticallyImplyLeading: true,
      ),

      /// ---------------- BODY ----------------
      /// - Empty state if no bookmarks exist
      /// - Otherwise show list of saved articles
      body: bookmarks.isEmpty
          ? Center(
              child: Text(
                AppStrings.noBookmarks,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontSize: context.hg(24),
                  color: context.isDark
                      ? AppColors.whiteColorBorder
                      : AppColors.blackColor,
                ),
              ),
            )
          : ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                return ContainerNewsDetails(
                  articlesDataModel: bookmarks[index],

                  /// No search filtering in bookmarks screen
                  searchQuery: '',

                  /// Callback when user removes bookmark
                  onBookmarkRemoved: _removeBookmark,

                  /// Force UI to show bookmarked state
                  forceBookmarked: true,
                );
              },
            ),
    );
  }
}
