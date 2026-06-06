import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/id/injection.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/core/widgets/components/shimmer_custom.dart';
import 'package:news/features/news/data/data_sources/models/category_data.dart';
import 'package:news/core/network/network%20handler/network_exception.dart';
import 'package:news/features/news/presentation/cubit/home/home_cubit.dart';
import 'package:news/features/news/presentation/cubit/news/news_state.dart';
import 'package:news/features/news/presentation/cubit/sources/sources_state.dart';
import 'package:news/features/news/presentation/views/news/news_view.dart';
import 'package:news/features/news/presentation/views/sources/sources_view.dart';

/// Main content page for a selected news category.
///
/// Responsible for:
/// - Loading available news sources for the category
/// - Fetching articles from the selected source
/// - Handling loading, error, and success states
/// - Connecting [SourcesView] and [NewsView]
///
/// Example:
/// ```dart
/// PageNewsData(
///   categoryData: selectedCategory,
/// )
/// ```
class PageNewsData extends StatefulWidget {
  /// The selected category whose sources and articles will be displayed.
  final CategoryData categoryData;

  const PageNewsData({super.key, required this.categoryData});

  @override
  State<PageNewsData> createState() => _PageNewsDataState();
}

class _PageNewsDataState extends State<PageNewsData> {
  /// Manages source-related operations and states.
  late SourcesCubit sourcesCubit;

  @override
  void initState() {
    super.initState();

    // Initialize SourcesCubit from dependency injection
    sourcesCubit = getIt<SourcesCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeState = context.read<HomeCubit>().state;
        final currentCountry = homeState.country;

        // Load sources for the selected category and country
        sourcesCubit.getSourcesByCategoryAndCountry(
          categoryId: widget.categoryData.id,
          country: currentCountry,
        );
        // Automatically load articles from the first source
        // when sources are successfully fetched
        sourcesCubit.stream.listen((state) {
          if (state is SourcesLoaded && state.sources.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<NewsCubit>().getAllArticles(
                sourceId: state.sources[0].id,
              );
            });
          }
        });

        return sourcesCubit;
      },
      child: BlocBuilder<SourcesCubit, SourcesState>(
        builder: (context, sourcesState) {
          return BlocBuilder<NewsCubit, NewsState>(
            builder: (context, newsState) {
              // Display shimmer placeholders while sources are loading
              if (sourcesState is SourcesLoading ||
                  sourcesState is InitialSourcesState) {
                return const Column(
                  children: <Widget>[
                    ShimmerCustom(isTabBar: true),
                    Expanded(child: ShimmerCustom(isNews: true)),
                  ],
                );
              }

              // Display source loading error with retry option
              if (sourcesState is SourcesError) {
                final message = sourcesState.failedMessage;
                final icon = NetworkException(message).icon;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        icon,
                        size: context.hg(60),
                        color: context.isDark
                            ? AppColors.primaryColorLight
                            : AppColors.primaryColorDark,
                      ),
                      SizedBox(height: context.hg(16)),
                      Text(
                        message,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.isDark
                              ? AppColors.primaryColorLight
                              : AppColors.primaryColorDark,
                          fontSize: context.hg(18),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: context.hg(16)),
                      // Retry loading sources
                      Bounceable(
                        onTap: () {
                          final country = context
                              .read<HomeCubit>()
                              .state
                              .country;
                          context
                              .read<SourcesCubit>()
                              .getSourcesByCategoryAndCountry(
                                categoryId: widget.categoryData.id,
                                country: country,
                              );
                        },
                        child: Icon(
                          Icons.refresh_rounded,
                          size: context.hg(40),
                          color: context.isDark
                              ? AppColors.primaryColorLight
                              : AppColors.primaryColorDark,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Main content layout
              return Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: context.hg(16)),
                    // Available news sources
                    child: SourcesView(
                      selectedCategory: widget.categoryData,
                      onTabChanged: (sourceId) {
                        context.read<NewsCubit>().getAllArticles(
                          sourceId: sourceId,
                        );
                      },
                    ),
                  ),
                  // News articles list
                  const Expanded(child: NewsView()),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
