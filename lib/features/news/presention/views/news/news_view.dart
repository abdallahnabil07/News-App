import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/core/widgets/components/shimmer_custom.dart';
import 'package:news/features/news/presention/cubit/news/news_state.dart';
import 'package:news/features/news/presention/widgets/news/container_news_details.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final controller = ScrollController();
  NewsCubit? _cubit; // ✅ nullable

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (!mounted) return;
      _cubit?.loadMore(); // ✅ مش بيحتاج context
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit ??= context.read<NewsCubit>(); // ✅ احفظه مرة واحدة بس
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorBg = context.isDark
        ? AppColors.primaryColorLight
        : AppColors.primaryColorDark;
    final colorProgress = context.isDark
        ? AppColors.darkGreyColor
        : AppColors.lightGreyColor;

    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        final cubit = context.read<NewsCubit>();
        switch (state) {
          case InitialNewsState():
          case NewsLoading():
            return const ShimmerCustom(isNews: true);

          case NewsLoadingMore():
          case NewsLoaded():
          case NewsSearching():
            final articles = cubit.articles;

            if (articles.isEmpty) {
              return Center(
                child: Text(
                  cubit.isSearching ? "No results found" : "No news available",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.isDark
                        ? AppColors.primaryColorLight
                        : AppColors.primaryColorDark,
                    fontSize: context.hg(20),
                  ),
                ),
              );
            }
            return RefreshIndicator(
              backgroundColor: colorBg,
              color: context.isDark
                  ? AppColors.primaryColorDark
                  : AppColors.primaryColorLight,
              onRefresh: cubit.refresh,
              child: ListView.builder(
                controller: controller,
                itemCount: cubit.hasMore
                    ? articles.length + 1
                    : articles.length,
                itemBuilder: (context, index) {
                  if (index < articles.length) {
                    return ContainerNewsDetails(
                      articlesDataModel: articles[index],
                      searchQuery: cubit.searchQuery,
                    );
                  } else {
                    return cubit.hasMore
                        ? Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: colorBg,
                                color: colorProgress,
                              ),
                            ),
                          )
                        : const SizedBox();
                  }
                },
              ),
            );

          case NewsError():
            return Center(
              child: Text(
                state.failedMessage,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: context.isDark
                      ? AppColors.primaryColorLight
                      : AppColors.primaryColorDark,
                  fontSize: context.hg(20),
                ),
              ),
            );
        }
      },
    );
  }
}
