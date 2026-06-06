import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news/core/constants/app_strings.dart';
import 'package:news/core/settings/setting_cubit.dart';
import 'package:news/core/routes/app_routes.dart';
import 'package:news/core/routes/app_routes_name.dart';
import 'package:news/core/theme/app_theme.dart';

import 'core/id/injection.dart';
import 'core/services/loading_services.dart';
import 'core/services/notification_service.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('bookmarks');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  configureDependencies();
  final settingsCubit = SettingsCubit();
  configLoading();
  await settingsCubit.loadTheme();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.init();
  runApp(BlocProvider(create: (_) => settingsCubit, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          builder: EasyLoading.init(),
          themeMode: themeMode,
          darkTheme: AppTheme.darkMode,
          theme: AppTheme.lightMode,
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          initialRoute: AppRoutesName.splashScreen,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
