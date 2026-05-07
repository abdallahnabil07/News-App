import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/gen/assets.gen.dart';
import 'package:news/core/id/injection.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/core/widgets/components/custom_text_field.dart';
import 'package:news/core/widgets/components/drawer_custom.dart';
import 'package:news/features/news/data/data_sources/models/category_list.dart';
import 'package:news/features/news/presention/cubit/home/home_cubit.dart';
import 'package:news/features/news/presention/cubit/news/news_state.dart';
import 'package:news/features/news/presention/views/news/page_news_data.dart';
import 'package:news/features/news/presention/widgets/home/category_container_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  late final HomeCubit _homeCubit;
  late final NewsCubit _newsCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit();
    _newsCubit = getIt<NewsCubit>();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _homeCubit),
        BlocProvider.value(value: _newsCubit),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.watch<HomeCubit>();

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: !state.isSearching,
              title: state.isSearching
                  ? CustomTextField(
                      onChanged: (value) {
                        context.read<NewsCubit>().onSearch(value);
                      },
                      width: double.infinity,
                      height: context.hg(50),
                      hintText: "Search..",
                      fillColor: Colors.transparent,
                      borderColor: context.isDark
                          ? AppColors.primaryColorLight
                          : AppColors.primaryColorDark,
                      controller: searchController,

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
                            searchController.clear();
                            context.read<NewsCubit>().stopSearch();
                            cubit.toggleSearch();
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
                  : Text(state.selectedCategory?.name ?? "Home"),
              actions: state.isSearching || state.selectedCategory == null
                  ? []
                  : [
                      //Icon Search
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.paddingWidth16,
                        ),
                        child: Bounceable(
                          onTap: () {
                            final newsCubit = context.read<NewsCubit>();
                            final homeCubit = context.read<HomeCubit>();

                            newsCubit.startSearch();
                            homeCubit.toggleSearch();
                          },
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
            drawer: state.isSearching
                ? null
                : DrawerCustom(
                    onTap: () {
                      cubit.goHome();
                      Navigator.pop(context);
                    },
                  ),
            body: state.selectedCategory == null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.paddingWidth16,
                          vertical: context.paddingHeight16,
                        ),
                        child: Text(
                          "Good Morning\nHere is Some News For You",
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontSize: context.hg(24),
                            fontWeight: FontWeight.w500,
                            color: context.isDark
                                ? AppColors.primaryColorLight
                                : AppColors.primaryColorDark,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: CategoryList.categories.length,
                          itemBuilder: (context, index) {
                            return CategoryContainerCustom(
                              onTab: cubit.selectCategory,
                              isLeft: index % 2 == 0,
                              categoryData: CategoryList.categories[index],
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : PageNewsData(categoryData: state.selectedCategory!),
          );
        },
      ),
    );
  }
}
