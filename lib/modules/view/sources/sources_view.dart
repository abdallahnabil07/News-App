import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/components/custom_elevated_button.dart';
import 'package:news/components/default_tab_controller_custom.dart';
import 'package:news/components/shimmer_custom.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/gen/assets.gen.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/model/category_data.dart';
import 'package:news/modules/cubit/sources/sources_state.dart';

class SourcesView extends StatelessWidget {
  final CategoryData selectedCategory;
  final void Function(String sourceId) onTabChanged;

  const SourcesView({
    super.key,
    required this.selectedCategory,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourcesCubit, SourcesState>(
      builder: (context, state) {
        switch (state) {
          case InitialSourcesState():
            return const SizedBox();
          case SourcesLoading():
            return ShimmerCustom(isTabBar: true);
          case SourcesTabChanged():
          case SourcesLoaded():
            final cubit = context.read<SourcesCubit>();
            return CustomDefaultTabController(
              categoryData: selectedCategory,
              sourceDataList: cubit.sourceData,
              currentIndex: cubit.currentIndex,
              onTabChanged: (index) {
                cubit.changeTab(index);
                onTabChanged(cubit.sourceData[index].id);
              },
            );
          case SourcesError():
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.failedMessage,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.redColor,
                    fontSize: context.hg(20),
                  ),
                ),
                Assets.images.serverErrorDarkModeProcessed.image(),
                CustomElevatedButton(
                  textButton: "Try again",
                  onPressed: () {
                    context.read<SourcesCubit>().getAllSources(
                      selectedCategory.id,
                    );
                  },
                ),
              ],
            );
        }
      },
    );
  }
}
