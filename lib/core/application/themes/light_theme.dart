import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resource/app_colors.dart';
import '../resource/app_padding.dart';
import '../resource/app_size.dart';
import '../resource/app_styles.dart';

abstract class LightTheme {
  static ThemeData lightTheme({required BuildContext context}) {
    return ThemeData(
      primaryColor: AppColors.primary,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: AppColors.black),
      scaffoldBackgroundColor: AppColors.lightBackground,
      appBarTheme: AppBarThemeData(
        backgroundColor: AppColors.lightBackground,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          //ios only
          statusBarBrightness: Brightness.light,
          //android only
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.transparent,
        elevation: AppSize.s8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSize.s20),
            topRight: Radius.circular(AppSize.s20),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(overlayColor: AppColors.primary),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          overlayColor: AppColors.primary,
          textStyle: AppStyles.getRegularStyle(context: context, color: AppColors.primary, fontSize: AppSize.s20),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(color: AppColors.black),
          overlayColor: AppColors.white,
          backgroundColor: AppColors.primary,
          minimumSize: Size(double.infinity, AppSize.s50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(AppSize.s20),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: AppSize.s2,
        surfaceTintColor: Colors.transparent,
        color: AppColors.lightSurface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p10,
          vertical: AppPadding.p12,
        ),
        filled: true,
        fillColor: AppColors.lightInputBackground,
        labelStyle: AppStyles.getLightStyle(fontSize: AppSize.s20, context: context, color: AppColors.black),
        hintStyle: AppStyles.getLightStyle(fontSize: AppSize.s20, context: context, color: AppColors.black),
        errorStyle: AppStyles.getRegularStyle(
          fontSize: AppSize.s22,
          color: AppColors.lightError,
          context: context,
        ),
        // enabled border
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
            width: AppSize.s1_5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
        ),
        // focused border
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
        ),
        //error border
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightError, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
        ),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightError, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
        ),
      ),

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: AppColors.primary.withValues(alpha: 0.25),
        selectionHandleColor: AppColors.primary,
      ),
    );
  }
}
