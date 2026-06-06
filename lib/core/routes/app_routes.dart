import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/routes/widget/page_route_builder_custom.dart';
import 'package:news/features/news/presentation/cubit/home/home_cubit.dart';
import 'package:news/features/news/presentation/views/bookmark/bookmark_view.dart';
import 'package:news/features/news/presentation/views/home/home_screen.dart';
import 'package:news/features/news/presentation/views/splash/splash_screen.dart';

import 'app_routes_name.dart';

abstract class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.homeScreen:
        return PageRouteBuilderCustom(
          page: BlocProvider(
              create: (_) => HomeCubit(), child: const HomeScreen()),
          arguments: settings,
        );
      case AppRoutesName.splashScreen:
        return PageRouteBuilderCustom(
          page: const SplashScreen(),
          arguments: settings,
        );
      case AppRoutesName.bookmark:
        return PageRouteBuilderCustom(
          page: const BookmarkView(),
          arguments: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                  create: (_) => HomeCubit(), child: const HomeScreen()),
        );
    }
  }
}
