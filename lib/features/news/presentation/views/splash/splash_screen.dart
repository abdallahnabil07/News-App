import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/constants/app_strings.dart';
import 'package:news/core/extensions/context_extensions.dart';
import 'package:news/core/routes/app_routes_name.dart';

/// Initial screen shown when the app launches.
///
/// Displays the app title for a short duration,
/// then automatically navigates to the Home Screen.
///
/// Example:
/// ```dart
/// MaterialApp(
///   home: SplashScreen(),
/// )
/// ```
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutesName.homeScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Center(
        // App title displayed during splash screen
        child: Text(
          AppStrings.exploreTheWorld,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: context.hg(40),
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
