import 'package:flutter/material.dart';

import '../../components/default_tab_controller_custom.dart';
import '../../custom_widget/container_news_details.dart';

class PageNewsData extends StatefulWidget {
  const PageNewsData({super.key});

  @override
  State<PageNewsData> createState() => _PageNewsDataState();
}

class _PageNewsDataState extends State<PageNewsData> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomDefaultTabController(),
          ...List.generate(1, (index) {
            return ContainerNewsDetails();
          }),
        ],
      ),
    );
  }
}
