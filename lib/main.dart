import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/provider/setting_cubit.dart';
import 'package:news/core/routes/app_routes.dart';
import 'package:news/core/routes/app_routes_name.dart';
import 'package:news/core/theme/app_theme.dart';

import 'core/id/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(BlocProvider(create: (_) => SettingsCubit(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          themeMode: themeMode,
          darkTheme: AppTheme.darkMode,
          theme: AppTheme.lightMode,
          debugShowCheckedModeBanner: false,
          title: 'News app',
          initialRoute: AppRoutesName.homeScreen,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
