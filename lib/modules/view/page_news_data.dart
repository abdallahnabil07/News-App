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

  @override
  void initState() {
    homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.getAllSources(widget.categoryData.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, _) {
        return Column(
          children: [
            //TAB BAR
            CustomDefaultTabController(
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
                  if (viewModel.articles.isEmpty) {
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
                  return ListView.builder(
                    itemCount: viewModel.articles.length,
                    itemBuilder: (context, index) {
                      return ContainerNewsDetails(
                        articlesDataModel: viewModel.articles[index],
                      );
                    },
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
