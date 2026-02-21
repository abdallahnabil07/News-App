import 'package:flutter/material.dart';
import 'package:news/components/shimmer_custom.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/modules/view%20model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../components/default_tab_controller_custom.dart';
import '../../custom_widget/container_news_details.dart';
import '../../model/category_data.dart';

class PageNewsData extends StatefulWidget {
  final CategoryData categoryData;

  const PageNewsData({super.key, required this.categoryData});

  @override
  State<PageNewsData> createState() => _PageNewsDataState();
}

class _PageNewsDataState extends State<PageNewsData> {
  late final HomeViewModel homeViewModel;
  final controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeViewModel.getAllSources(widget.categoryData.id);
    });
    controller.addListener(() {
      if (!homeViewModel.isSearching && controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        homeViewModel.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorRefreshAndCircularProgressBackground = context.isDark
        ? AppColors.primaryColorLight
        : AppColors.primaryColorDark;
    final colorCircularProgress = context.isDark
        ? AppColors.darkGreyColor
        : AppColors.lightGreyColor;
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, _) {
        return Column(
          children: [
            //TAB BAR
            homeViewModel.isSearching
                ? SizedBox(height: context.paddingHeight16,)
                : CustomDefaultTabController(
              categoryData: widget.categoryData,
              sourceDataList: viewModel.sourceData,
              currentIndex: viewModel.currentIndex,
              onTabChanged: viewModel.onTapChaneTapBar,
            ),

            // NEWS LIST
            Expanded(
              child: Builder(
                builder: (context) {
                  if (viewModel.isLoading) {
                    return ShimmerCustom();
                  }
                  if (viewModel.errorMessage != null) {
                    return Center(
                      child: Text(
                        viewModel.errorMessage!,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.isDark
                              ? AppColors.primaryColorLight
                              : AppColors.primaryColorDark,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                  if (viewModel.articlesShow.isEmpty) {
                    return Center(
                      child: Text(
                        "No news",
                        style: context.textTheme.bodyLarge!.copyWith(
                          color: context.isDark
                              ? AppColors.primaryColorLight
                              : AppColors.primaryColorDark,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                  return RefreshIndicator(
                    backgroundColor: colorRefreshAndCircularProgressBackground,
                    color: context.isDark
                        ? AppColors.primaryColorDark
                        : AppColors.primaryColorLight,
                    onRefresh: viewModel.refresh,
                    child: ListView.builder(
                      controller: controller,
                      itemCount: viewModel.hasMore && !viewModel.isSearching
                          ? viewModel.articlesShow.length + 1
                          : viewModel.articlesShow.length,
                      itemBuilder: (context, index) {
                        if (index < viewModel.articlesShow.length) {
                          return ContainerNewsDetails(
                            articlesDataModel: viewModel.articlesShow[index],
                            searchQuery: viewModel.searchQuery,
                          );
                        } else {
                          return viewModel.hasMore
                              ? Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor:
                                colorRefreshAndCircularProgressBackground,
                                color: colorCircularProgress,
                              ),
                            ),
                          )
                              : const SizedBox();
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
