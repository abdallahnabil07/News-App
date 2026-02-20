import 'package:flutter/material.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/provider/app_setting_provider.dart';
import 'package:news/core/routes/app_routes.dart';
import 'package:news/core/routes/app_routes_name.dart';
import 'package:news/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppSettingProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: context.provider.currentTheme,
      darkTheme: AppTheme.darkMode,
      theme: AppTheme.lightMode,
      debugShowCheckedModeBanner: false,
      title: 'News app',
      initialRoute: AppRoutesName.homeScreen,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
