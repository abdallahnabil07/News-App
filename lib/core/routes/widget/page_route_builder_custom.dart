import 'package:flutter/material.dart';

class PageRouteBuilderCustom extends PageRouteBuilder {
  final Widget page;
  final Object? arguments;

  PageRouteBuilderCustom({required this.page, this.arguments})
    : super(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) => page,
        settings: RouteSettings(arguments: arguments),
        transitionDuration: const Duration(milliseconds: 300),

        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
      );
}
