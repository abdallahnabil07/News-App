import 'package:flutter/material.dart';
import 'package:news/core/routes/app_routes.dart';
import 'package:news/core/routes/app_routes_name.dart';
import 'package:news/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightMode,
      darkTheme: AppTheme.darkMode,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: 'News app',
      initialRoute: AppRoutesName.homeScreen,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}




