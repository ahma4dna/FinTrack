import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:flutter/material.dart';

import 'app_size.dart';

abstract class AppStyles {
  static TextStyle getRgularMono14({
    required BuildContext context,
    double? fontSize,
    Color? color,
  }) => TextStyle(
    color: color ?? const Color(0xFF64707A),
    fontSize: fontSize ?? AppSize.s14,
    fontFamily: 'IBM Plex Mono',
    fontWeight: FontWeight.w400,
  );
  static TextStyle getSemiBoldMono36({
    required BuildContext context,
    double? fontSize,
    Color? color,
  }) => TextStyle(
    color: color ?? const Color(0xFF121820),
    fontSize: fontSize ?? AppSize.s36,
    fontFamily: 'IBM Plex Mono',
    fontWeight: FontWeight.w600,
  );

  static TextStyle getSemiBoldSens20({
    required BuildContext context,
    double? fontSize,
    Color? color,
  }) => TextStyle(
    color: color ?? const Color(0xFF121820),
    fontSize: fontSize ?? 20,
    fontFamily: 'IBM Plex Sans Arabic',
    fontWeight: FontWeight.w600,
  );

  static TextStyle getSemiBoldSens18({
    required BuildContext context,
    double? fontSize,
    Color? color,
  }) => TextStyle(
    color: color ?? const Color(0xFF121820),
    fontSize: fontSize ?? 18,
    fontFamily: 'IBM Plex Sans Arabic',
    fontWeight: FontWeight.w600,
  );
  static TextStyle getBoldSens36({
    required BuildContext context,
    double? fontSize,
    Color? color,
  }) => TextStyle(
    color: color ?? AppColors.white,
    fontSize: fontSize ?? 36,
    fontFamily: 'IBM Plex Sans Arabic',
    fontWeight: FontWeight.w700,
  );
  static TextStyle getSemiBoldSens16({
    required BuildContext context,
    double? fontSize,
    Color? color,
  }) => TextStyle(
    color: color ?? const Color(0xFF121820),
    fontSize: fontSize ?? 16,
    fontFamily: 'IBM Plex Sans Arabic',
    fontWeight: FontWeight.w600,
  );

  static TextStyle getMeduimSens14({
    required BuildContext context,
    double? fontSize,
    Color? color,
  }) => TextStyle(
    color: color ?? Colors.white.withValues(alpha: 0.80),
    fontSize: fontSize ?? 14,
    fontFamily: 'IBM Plex Sans Arabic',
    fontWeight: FontWeight.w500,
  );

  static TextStyle getRegularSens14({
    required BuildContext context,
    double? fontSize,
    Color? color,
  }) => TextStyle(
    color: color ?? const Color(0xFF121820),
    fontSize: fontSize ?? 14,
    fontFamily: 'IBM Plex Sans Arabic',
    fontWeight: FontWeight.w400,
  );

  static TextStyle getMeduimSens12({
    required BuildContext context,
    double? fontSize,
    Color? color,
  }) => TextStyle(
    color: color ?? const Color(0xFF121820),
    fontSize: fontSize ?? 12,
    fontFamily: 'IBM Plex Sans Arabic',
    fontWeight: FontWeight.w500,
  );

  static TextStyle getRegularSens10({
    required BuildContext context,
    double? fontSize,
    Color? color,
  }) => TextStyle(
    color: color ?? const Color(0xFF121820),
    fontSize: fontSize ?? 10,
    fontFamily: 'IBM Plex Sans Arabic',
    fontWeight: FontWeight.w400,
  );

  static TextStyle getSemiBoldMono30({
    required BuildContext context,
    double? fontSize,
    Color? color,
  }) => TextStyle(
    color: color ?? const Color(0xFF121820),
    fontSize: fontSize ?? 30,
    fontFamily: 'IBM Plex Mono',
    fontWeight: FontWeight.w600,
  );

  static TextStyle getSemiBoldMono14({
    required BuildContext context,
    double? fontSize,
    Color? color,
  }) => TextStyle(
    color: color ?? const Color(0xFF121820),
    fontSize: fontSize ?? 14,
    fontFamily: 'IBM Plex Mono',
    fontWeight: FontWeight.w600,
  );

  static TextStyle getRegularMono12({
    required BuildContext context,
    double? fontSize,
    Color? color,
  }) => TextStyle(
    color: color ?? const Color(0xFF121820),
    fontSize: fontSize ?? 14,
    fontFamily: 'IBM Plex Mono',
    fontWeight: FontWeight.w400,
  );
}

double getResponsiveSize({
  required BuildContext context,
  required double fontSize,
}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = scaleFactor * fontSize;
  double lowerLimit = fontSize * AppSize.s0_8;
  double upperLimit = fontSize * AppSize.s1_5;
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
