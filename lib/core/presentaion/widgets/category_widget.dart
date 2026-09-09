import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CategoryWidget extends StatelessWidget {
  final String catNmae;
  final String icon;
  final String selctedCat;

  final void Function() onTap;
  const CategoryWidget({
    super.key,
    required this.catNmae,
    required this.icon,
    required this.selctedCat,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(
          vertical: AppPadding.p10,
          horizontal: AppPadding.p12,
        ),
        decoration: BoxDecoration(
          color: selctedCat != catNmae ? AppColors.lightBackground : AppColors.primary,
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/icon/$icon.svg",
              width: AppSize.s24,
              height: AppSize.s24,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                selctedCat != catNmae ? Color(0xFF121820) : Color(0xFFFFFFFF),
                BlendMode.srcIn,
              ),
            ),
            const Gap(AppSize.s8),
            Text(
              catNmae,
              style: AppStyles.getMeduimSens12(
                context: context,
                fontSize: AppSize.s16,
                color: selctedCat != catNmae ? const Color(0xFF121820) : const Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
