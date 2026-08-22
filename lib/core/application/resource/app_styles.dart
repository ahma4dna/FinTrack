import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_size.dart';

abstract class AppStyles {
  static TextStyle getBoldStyle({
    required BuildContext context,
    double fontSize = AppSize.s45,
    // Color color = AppColors.primary,
    Color? color,
  }) => TextStyle(
    color: colorApp(context, color),
    fontSize: getResponsiveSize(context: context, fontSize: fontSize),
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w700,
  );

  static TextStyle getSemiBoldStyle({
    required BuildContext context,
    double fontSize = AppSize.s45,
    // Color color = AppColors.primary,
    Color? color,
  }) => TextStyle(
    color: colorApp(context, color),
    fontSize: getResponsiveSize(context: context, fontSize: fontSize),
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w500,
  );

  static TextStyle getRegularStyle({
    required BuildContext context,
    double fontSize = AppSize.s25,
    // Color color = Colors.white,
    Color? color,
  }) => TextStyle(
    color: colorApp(context, color),
    fontSize: getResponsiveSize(context: context, fontSize: fontSize),
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w400,
  );

  static TextStyle getMediumStyle({
    required BuildContext context,
    double fontSize = AppSize.s25,
    // Color color = Colors.white,
    Color? color,
  }) => TextStyle(
    color: colorApp(context, color),
    fontSize: getResponsiveSize(context: context, fontSize: fontSize),
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w500,
  );

  static TextStyle getLightStyle({
    required BuildContext context,
    double fontSize = AppSize.s20,
    // Color color = Colors.white,
    Color? color,
  }) => TextStyle(
    color: colorApp(context, color),
    fontSize: getResponsiveSize(context: context, fontSize: fontSize),
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w300,
  );
}

double getResponsiveSize({
  required BuildContext context,
  required double fontSize,
}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = scaleFactor * fontSize;
  double lowerLimit = fontSize * AppSize.s0_8;
  double upperLimit = fontSize * AppSize.s1;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;
  if (width < AppSizeConfig.tablet) {
    return width / AppSize.s550;
  } else if (width < AppSizeConfig.deskTop) {
    return width / AppSize.s1000;
  } else {
    return width / AppSize.s1920;
  }
}

Color? colorApp(BuildContext context, Color? color) {
  final isDark = Theme.of(context).brightness == Brightness.dark
      ? AppColors.white
      : AppColors.black;
  return color ?? isDark;
}

class AppSizeConfig {
  static const double deskTop = AppSize.s1200;
  static const double tablet = AppSize.s800;

  //not use if project content web or desk top or change withe or height reel time
  static late double withe, height;

  static void init(BuildContext context) {
    withe = MediaQuery.sizeOf(context).width;
    height = MediaQuery.sizeOf(context).height;
  }
}
