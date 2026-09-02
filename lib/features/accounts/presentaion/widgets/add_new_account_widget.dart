import 'package:dotted_border/dotted_border.dart';
import 'package:fintrack/core/application/resource/app_assets.dart';
import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class AddNewAccountWidget extends StatelessWidget {
  const AddNewAccountWidget({super.key, required this.onTap});
  final void Function() onTap;
  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox(
      width: double.infinity,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: [10, 5],
          strokeWidth: 2,
          radius: Radius.circular(16),
          color: Color(0xFFE4E8EA),
          padding: EdgeInsets.all(16),
        ),
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.add,
                  width: AppSize.s22,
                  height: AppSize.s22,
                  colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                ),
                const Gap(AppSize.s8),
                Text(
                  AppContext.of(context).localText.add_new_account,
                  style: AppStyles.getMeduimSens14(
                    context: context,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
