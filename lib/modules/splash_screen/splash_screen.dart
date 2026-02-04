//
// import 'package:flutter/material.dart';
//
// import '../../core/gen/assets.gen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 2), () {
//       Navigator.pushReplacementNamed(
//           context, AppRoutesName.onBoardingFirstPage);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           Center(
//             child: Assets.images.logoChange.image(
//               width: context.width * 0.80,
//               height: context.height * 0.44,
//             ),
//           ),
//
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: EdgeInsets.only(bottom: context.height * 0.055),
//               child: Assets.images.routeLogoSplashFooterChange.image(
//                 width: context.width * 0.17,
//                 height: context.paddingHeight32,
//               ),
//             ),
//           ),
//
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: EdgeInsets.only(bottom: context.height * 0.035),
//               child: Text(
//                 textAlign: TextAlign.center,
//                 context.appLocalizations.supervisedByMohamedNabil,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
