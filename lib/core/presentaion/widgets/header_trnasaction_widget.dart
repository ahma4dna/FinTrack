import 'package:fintrack/core/application/resource/app_assets.dart';
import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderTrnasactionWidget extends StatelessWidget {
  const new({
    super.key,
    required this.appContext,
  });

  final AppContext appContext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appContext.localText.new_tranaction,
          style: AppStyles.getSemiBoldSens18(
            context: context,
            fontSize: AppSize.s24,
          ),
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: AppSize.s35,
            width: AppSize.s35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightBackground,
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.close,
                height: AppSize.s25,
                width: AppSize.s25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
