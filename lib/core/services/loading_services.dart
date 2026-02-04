import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../theme/app_colors.dart';

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 12.0
    ..maskType = EasyLoadingMaskType.black
    ..backgroundColor =AppColors.primaryColorDark
    ..indicatorColor = AppColors.primaryColorLight
    ..textColor = AppColors.lightGreyColor
    ..userInteractions = false
    ..dismissOnTap = false;
}