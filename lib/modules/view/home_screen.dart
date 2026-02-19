import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(homeViewModel.selectedCategory?.name ?? "Home"),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.paddingWidth16,
                  ),
                  child: Bounceable(
                    onTap: () {},
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
            drawer: DrawerCustom(
                onTap: () {
                  homeViewModel.goToHome(context);
                }

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
