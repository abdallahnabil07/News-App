import 'package:flutter/material.dart';
import 'package:news/core/routes/widget/page_route_builder_custom.dart';
import 'package:news/modules/view/home/home_screen.dart';
import 'app_routes_name.dart';

abstract class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.homeScreen:
        return PageRouteBuilderCustom(page: HomeScreen(), arguments: settings);
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
