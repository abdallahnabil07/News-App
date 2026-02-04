import 'package:flutter/material.dart';
import 'package:news/core/routes/app_routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News app',
      initialRoute: AppRoutesName.homeScreen,
    );
  }
}




