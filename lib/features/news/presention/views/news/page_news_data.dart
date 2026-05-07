import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/id/injection.dart';
import 'package:news/features/news/data/data_sources/models/category_data.dart';
import 'package:news/features/news/presention/cubit/news/news_state.dart';
import 'package:news/features/news/presention/cubit/sources/sources_state.dart';
import 'package:news/features/news/presention/views/news/news_view.dart';
import 'package:news/features/news/presention/views/sources/sources_view.dart';

class PageNewsData extends StatefulWidget {
  final CategoryData categoryData;

  const PageNewsData({super.key, required this.categoryData});

  @override
  State<PageNewsData> createState() => _PageNewsDataState();
}

class _PageNewsDataState extends State<PageNewsData> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<SourcesCubit>();

        cubit.getAllSources(widget.categoryData.id);

        cubit.stream.listen((state) {
          if (state is SourcesLoaded && state.sources.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<NewsCubit>().getAllArticles(
                sourceId: state.sources[0].id,
              );
            });
          }
        });

        return cubit;
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: context.hg(16),),
            child: SourcesView(
              selectedCategory: widget.categoryData,
              onTabChanged: (sourceId) {
                context.read<NewsCubit>().getAllArticles(sourceId: sourceId);
              },
            ),
          ),

          Expanded(child: NewsView()),
        ],
      ),
    );
  }
}
