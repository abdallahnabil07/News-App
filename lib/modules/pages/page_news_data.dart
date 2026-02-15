import 'package:flutter/material.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/model/api/articles_data_model.dart';
import 'package:news/network%20handler/network_handler.dart';

import '../../components/default_tab_controller_custom.dart';
import '../../custom_widget/container_news_details.dart';
import '../../model/api/source_data_model.dart';
import '../../model/category_data.dart';

class PageNewsData extends StatefulWidget {
  final CategoryData categoryData;

  const PageNewsData({super.key, required this.categoryData});

  @override
  State<PageNewsData> createState() => _PageNewsDataState();
}

class _PageNewsDataState extends State<PageNewsData> {
  late Future<List<SourceData>> _sourcesFuture;
  late List<SourceData> sourceData;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _sourcesFuture = NetworkHandler.getAllSource(widget.categoryData.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SourceData>>(
      future: _sourcesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error loading sources",
              style: context.textTheme.bodyMedium!.copyWith(
                fontSize: 20,
                color: context.isDark
                    ? AppColors.primaryColorLight
                    : AppColors.primaryColorDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }

        final sourceData = snapshot.data ?? [];

        if (sourceData.isEmpty) {
          return Center(
            child: Text(
              "No Sources",
              style: context.textTheme.bodyMedium!.copyWith(
                fontSize: 20,
                color: context.isDark
                    ? AppColors.primaryColorLight
                    : AppColors.primaryColorDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }

        return Column(
          children: [
            //TAB BAR
            CustomDefaultTabController(
              categoryData: widget.categoryData,
              sourceDataList: sourceData,
              currentIndex: _currentIndex,
              onTabChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),

            // NEWS LIST
            Expanded(
              child: FutureBuilder<List<ArticlesDataModel>>(
                future: NetworkHandler.getNews(sourceData[_currentIndex].id),
                builder: (context, articleSnapshot) {
                  if (articleSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (articleSnapshot.hasError) {
                    return const Center(child: Text("Error loading news"));
                  }

                  final articles = articleSnapshot.data ?? [];

                  return ListView.builder(
                    itemCount: articles.length,

                    itemBuilder: (context, index) {
                      return ContainerNewsDetails(
                        articlesDataModel: articles[index],
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

