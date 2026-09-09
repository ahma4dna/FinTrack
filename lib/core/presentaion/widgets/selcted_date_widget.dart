import 'package:fintrack/core/application/resource/app_assets.dart';
import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SelctedDateWidget extends StatelessWidget {
  const SelctedDateWidget({
    super.key,
    required this.selctDate,
    required this.pickDate,
  });

  final DateTime? selctDate;
  final Future<void> Function(BuildContext context) pickDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p14,
      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          side: BorderSide(
            width: AppSize.s1,
            color: AppColors.border,
          ),
        ),
      ),
      child: InkWell(
        onTap: () async => pickDate(context),
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.date,
              width: AppSize.s25,
              height: AppSize.s25,
              fit: BoxFit.cover,
            ),
            const Gap(AppSize.s10),
            //selct date
            Text(
              selctDate == null ? "اختر تاريخ" : '${selctDate!.day}/${selctDate!.month}/${selctDate!.year}',
              style: AppStyles.getMeduimSens14(
                context: context,
                fontSize: AppSize.s18,
                color: Color(0xFF121820),
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              AppAssets.arrowDowen,
              width: AppSize.s25,
              height: AppSize.s25,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
