import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news/core/constants/app_strings.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/network/network%20handler/network_exception.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/features/news/presentation/cubit/news/news_state.dart';
import 'package:news/features/news/presentation/widgets/news/container_news_details.dart';

/// Displays a list of news articles with support for:
/// - Infinite scrolling (pagination)
/// - Pull-to-refresh
/// - Search results
/// - Error handling and retry
///
/// Listens to [NewsCubit] state changes and updates the UI
/// based on the current news loading status.
///
/// Example:
/// ```dart
/// Expanded(
///   child: NewsView(),
/// )
/// ```
class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  /// Controls scrolling and detects when more articles should be loaded.
  final controller = ScrollController();
  NewsCubit? _cubit;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (!mounted) return;

      // Load more articles when the user is near the bottom
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        _cubit?.loadMore();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Cache cubit reference once dependencies are available
    _cubit ??= context.read<NewsCubit>();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorBackground = context.isDark
        ? AppColors.primaryColorLight
        : AppColors.primaryColorDark;
    final colorProgress = context.isDark
        ? AppColors.darkGreyColor
        : AppColors.lightGreyColor;

    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        final cubit = context.read<NewsCubit>();
        switch (state) {
          // Initial and loading states
          case InitialNewsState():
          case NewsLoading():
            return const SizedBox();

          // Error state with retry action
          case NewsError():
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    NetworkException(state.failedMessage).icon,
                    size: context.hg(60),
                    color: context.isDark
                        ? AppColors.primaryColorLight
                        : AppColors.primaryColorDark,
                  ),
                  SizedBox(height: context.hg(16)),
                  Text(
                    state.failedMessage,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: context.isDark
                          ? AppColors.primaryColorLight
                          : AppColors.primaryColorDark,
                      fontSize: context.hg(18),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.hg(16)),

                  // Retry button
                  Bounceable(
                    onTap: () => context.read<NewsCubit>().retry(),
                    child: Icon(
                      Icons.refresh_rounded,
                      size: context.hg(40),
                      color: colorBackground,
                    ),
                  ),
                ],
              ),
            );

          // Loaded, searching, and pagination states
          case NewsLoadingMore():
          case NewsLoaded():
          case NewsSearching():
            final articles = cubit.articles;

            // Empty state
            if (articles.isEmpty) {
              return Center(
                child: Text(
                  cubit.isSearching ? AppStrings.noResults : AppStrings.noNews,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: colorBackground,
                    fontSize: context.hg(20),
                  ),
                ),
              );
            }
            return RefreshIndicator(
              backgroundColor: colorBackground,
              color: context.isDark
                  ? AppColors.primaryColorDark
                  : AppColors.primaryColorLight,

              // Pull-to-refresh action
              onRefresh: cubit.refresh,
              child: ListView.builder(
                controller: controller,
                itemCount: (cubit.hasMore && !cubit.isSearching)
                    ? articles.length + 1
                    : articles.length,
                itemBuilder: (context, index) {
                  // News article item
                  if (index < articles.length) {
                    return ContainerNewsDetails(
                      articlesDataModel: articles[index],
                      searchQuery: cubit.searchQuery,
                    );
                  } else {
                    // Pagination loading indicator
                    return cubit.hasMore
                        ? Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: colorBackground,
                                color: colorProgress,
                              ),
                            ),
                          )
                        : const SizedBox();
                  }
                },
              ),
            );
        }
      },
    );
  }
}
