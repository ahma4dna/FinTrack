import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:flutter/material.dart';

class TypeAccountWidget extends StatelessWidget {
  const TypeAccountWidget({
    super.key,
    required this.appContext,
    required this.selctIndex,
    required this.inedx,
    required this.type,
    required this.onTap,
  });

  final AppContext appContext;
  final int selctIndex;
  final int inedx;
  final String type;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isActive = selctIndex == inedx;
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p38,
          vertical: AppPadding.p12,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.transparent,
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        child: Text(
          type,
          style: AppStyles.getMeduimSens14(
            context: context,
            color: isActive ? AppColors.white : Color(0xFF121820),
            fontSize: AppSize.s18,
          ),
        ),
      ),
    );
  }
}
