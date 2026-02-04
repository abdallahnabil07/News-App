import 'package:flutter/material.dart';
import 'package:news/home_screen.dart';

import 'app_routes_name.dart';

abstract class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
