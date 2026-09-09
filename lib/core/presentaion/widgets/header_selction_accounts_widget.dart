import 'package:fintrack/core/application/resource/app_assets.dart';
import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderSelctionAccountsWidget extends StatelessWidget {
  const HeaderSelctionAccountsWidget({
    super.key,
    required this.appContext,
    this.onTapPop,
  });

  final AppContext appContext;
  final void Function()? onTapPop;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appContext.localText.selection_account,
          style: AppStyles.getSemiBoldSens18(
            context: context,
            fontSize: AppSize.s24,
          ),
        ),
        InkWell(
          onTap: onTapPop,
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
