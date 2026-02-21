import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news/components/custom_text_field.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/gen/assets.gen.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/model/category_list.dart';
import 'package:news/modules/view%20model/home_view_model.dart';
import 'package:news/modules/view/page_news_data.dart';
import 'package:provider/provider.dart';

import '../../components/drawer_custom.dart';
import '../../custom_widget/category_container_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, _) {
          return Scaffold(
            appBar: AppBar(
              title: homeViewModel.isSearching
                  ? CustomTextField(
                      width: double.infinity,
                      height: 50,
                      hintText: "Search..",
                      fillColor: Colors.transparent,
                      borderColor: context.isDark
                          ? AppColors.primaryColorLight
                          : AppColors.primaryColorDark,
                      controller: searchController,
                      onChanged: (text) {
                        homeViewModel.onSearchTextChange(text);
                      },
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                          left: context.paddingWidth16,
                          right: context.paddingWidth8,
                        ),

                        child: Assets.icons.search.svg(
                          colorFilter: ColorFilter.mode(
                            context.isDark
                                ? AppColors.primaryColorLight
                                : AppColors.primaryColorDark,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),

                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: context.paddingWidth16),
                        child: Bounceable(
                          onTap: () {
                            homeViewModel.onTapXIconSearching(searchController);
                          },
                          child: Assets.icons.xIcon.svg(
                            colorFilter: ColorFilter.mode(
                              context.isDark
                                  ? AppColors.primaryColorLight
                                  : AppColors.primaryColorDark,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text(homeViewModel.selectedCategory?.name ?? "Home"),
              actions:
                  homeViewModel.isSearching ||
                      homeViewModel.selectedCategory == null
                  ? []
                  : [
                      //search icon
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.paddingWidth16,
                        ),
                        child: Bounceable(
                          onTap: homeViewModel.onTapIconSearching,
                          child: Assets.icons.search.svg(
                            colorFilter: ColorFilter.mode(
                              context.isDark
                                  ? AppColors.primaryColorLight
                                  : AppColors.primaryColorDark,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
            ),
            drawer: homeViewModel.isSearching
                ? null
                : DrawerCustom(
                    onTap: () {
                      homeViewModel.goToHome(context);
                    },
                  ),
            body: homeViewModel.selectedCategory == null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //Text
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.paddingWidth16,
                          vertical: context.paddingHeight16,
                        ),
                        child: Text(
                          "Good Morning\nHere is Some News For You",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: context.isDark
                                ? AppColors.primaryColorLight
                                : AppColors.primaryColorDark,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return CategoryContainerCustom(
                              onTab: (category) {
                                homeViewModel.onCategoryTap(category);
                              },
                              isLeft: index % 2 == 0,
                              categoryData: CategoryList.categories[index],
                            );
                          },
                          itemCount: CategoryList.categories.length,
                        ),
                      ),
                    ],
                  )
                : PageNewsData(categoryData: homeViewModel.selectedCategory!),
          );
        },
      ),
    );
  }
}
