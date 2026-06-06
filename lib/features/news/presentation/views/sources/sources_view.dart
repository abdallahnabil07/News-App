import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/widgets/components/default_tab_controller_custom.dart';
import 'package:news/features/news/data/data_sources/models/category_data.dart';
import 'package:news/features/news/presentation/cubit/sources/sources_state.dart';

/// Displays the available news sources for the selected category.
///
/// Listens to [SourcesCubit] state changes and shows a tab bar
/// containing all fetched sources. When the user selects a tab,
/// the source is updated and the selected source ID is returned
/// through [onTabChanged].
///
/// Example:
/// ```dart
/// SourcesView(
///   selectedCategory: category,
///   onTabChanged: (sourceId) {
///     context.read<NewsCubit>().getNews(sourceId);
///   },
/// )
/// ```
class SourcesView extends StatelessWidget {
  /// The currently selected news category.
  final CategoryData selectedCategory;

  /// Called when the selected source tab changes.
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

          // No sources available yet
          case InitialSourcesState():
          case SourcesLoading():
          case SourcesError():
            return const SizedBox();

        // Sources loaded successfully
          case SourcesTabChanged():
          case SourcesLoaded():
            final cubit = context.read<SourcesCubit>();
            return CustomDefaultTabController(
              categoryData: selectedCategory,
              sourceDataList: cubit.sourceData,
              currentIndex: cubit.currentIndex,
              onTabChanged: (index) {

                // Update selected source tab
                cubit.changeTab(index);

                // Notify parent widget of source change
                onTabChanged(cubit.sourceData[index].id);
              },
            );
        }
      },
    );
  }
}
