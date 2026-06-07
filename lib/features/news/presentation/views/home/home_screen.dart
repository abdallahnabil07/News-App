import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news/core/constants/app_strings.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/gen/assets.gen.dart';
import 'package:news/core/id/injection.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/core/widgets/components/custom_text_field.dart';
import 'package:news/core/widgets/components/drawer_custom.dart';
import 'package:news/features/news/data/data_sources/models/category_list.dart';
import 'package:news/features/news/presentation/cubit/home/home_cubit.dart';
import 'package:news/features/news/presentation/cubit/news/news_state.dart';
import 'package:news/features/news/presentation/views/news/page_news_data.dart';
import 'package:news/features/news/presentation/widgets/home/category_container_custom.dart';

/// Home screen of the News app.
///
/// Responsible for:
/// - Displaying available news categories
/// - Handling category selection and navigation to news content
/// - Managing search mode (global + category-based search)
/// - Coordinating [HomeCubit] and [NewsCubit]
///
/// Flow:
/// - If no category selected → show categories list
/// - If category selected → show [PageNewsData]
/// - If search enabled → show search UI in AppBar
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Controller for search input field
  final TextEditingController searchController = TextEditingController();

  /// Handles home-related UI state (selected category, search mode)
  late final HomeCubit _homeCubit;

  /// Handles news fetching and search logic
  late final NewsCubit _newsCubit;

  @override
  void initState() {
    super.initState();

    // Initialize cubits
    _homeCubit = HomeCubit()..init();
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

          return PopScope(
            canPop: state.selectedCategory == null,
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop && state.selectedCategory != null) {
                cubit.goHome();
              }
            },
            child: Scaffold(
              /// ---------------- APP BAR ----------------
              /// - Shows category title OR search field
              /// - Handles entering/exiting search mode
              appBar: AppBar(
                automaticallyImplyLeading: !state.isSearching,

                title: state.isSearching
                    ? _buildSearchField(context, state)
                    : Text(state.selectedCategory?.name ?? AppStrings.home),

                actions: _buildAppBarActions(context, state, cubit),
              ),

              /// ---------------- DRAWER ----------------
              /// Hidden during search mode
              drawer: state.isSearching
                  ? null
                  : DrawerCustom(
                      onTap: () {
                        cubit.goHome();
                        Navigator.pop(context);
                      },
                    ),

              /// ---------------- BODY ----------------
              /// - No category → show categories list
              /// - Category selected → show news data page
              body: state.selectedCategory == null
                  ? _buildCategoriesList(context, cubit)
                  : PageNewsData(categoryData: state.selectedCategory!),
            ),
          );
        },
      ),
    );
  }

  /// Builds search input field in AppBar
  Widget _buildSearchField(BuildContext context, HomeState state) {
    return CustomTextField(
      controller: searchController,
      width: double.infinity,
      height: context.hg(50),
      hintText: AppStrings.search,
      fillColor: Colors.transparent,
      borderColor: context.isDark
          ? AppColors.primaryColorLight
          : AppColors.primaryColorDark,

      onChanged: (value) {
        context.read<NewsCubit>().onSearch(value);
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
            // Clear search and exit search mode
            searchController.clear();

            if (state.selectedCategory == null) {
              context.read<HomeCubit>().onSearch('');
            } else {
              context.read<NewsCubit>().stopSearch();
            }

            context.read<HomeCubit>().toggleSearch();
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
    );
  }

  /// Builds AppBar action buttons (search icon)
  List<Widget> _buildAppBarActions(
    BuildContext context,
    HomeState state,
    HomeCubit cubit,
  ) {
    if (state.isSearching || state.selectedCategory == null) {
      return [];
    }

    return [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddingWidth16),
        child: Bounceable(
          onTap: () {
            context.read<NewsCubit>().startSearch();
            cubit.toggleSearch();
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
    ];
  }

  /// Builds categories list screen (home default state)
  Widget _buildCategoriesList(BuildContext context, HomeCubit cubit) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.paddingWidth16,
              vertical: context.paddingHeight16,
            ),
            child: Text(
              "${AppStrings.goodMorning}\n${AppStrings.homeSubtitle}",
              style: context.textTheme.bodyLarge!.copyWith(
                fontSize: context.hg(24),
                fontWeight: FontWeight.w500,
                color: context.isDark
                    ? AppColors.primaryColorLight
                    : AppColors.primaryColorDark,
              ),
            ),
          ),
        ),
        // Categories list
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => CategoryContainerCustom(
              onTab: cubit.selectCategory,
              isLeft: index % 2 == 0,
              categoryData: CategoryList.categories[index],
            ),
            childCount: CategoryList.categories.length,
          ),
        ),
      ],
    );
  }
}
