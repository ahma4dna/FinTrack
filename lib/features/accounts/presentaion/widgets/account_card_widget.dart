import 'package:fintrack/core/application/resource/app_assets.dart';
import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/constant.dart';
import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class AccountCardWidget extends StatelessWidget {
  final WalletModel walletModel;
  const AccountCardWidget({
    super.key,
    required this.walletModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: AppPadding.p16,
        bottom: AppPadding.p16,
        right: AppPadding.p16,
        left: AppPadding.p40,
      ),
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(AppSize.s16),
          side: BorderSide(
            width: 1,
            color: AppColors.border,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: AppSize.s50,
            width: AppSize.s50,
            decoration: ShapeDecoration(
              color: AppColors.lightBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/icon/${walletModel.iconName}.svg",
                height: AppSize.s25,
                width: AppSize.s25,
              ),
            ),
          ),
          const Gap(AppSize.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    walletModel.name,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    style: AppStyles.getMeduimSens14(
                      context: context,
                      fontSize: AppSize.s16,
                      color: Color(0xFF121820),
                    ),
                  ),
                ),
                const Gap(AppSize.s3),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    walletModel.type,
                    textAlign: TextAlign.right,
                    style: AppStyles.getRegularSens14(
                      context: context,
                      fontSize: AppSize.s14,
                      color: Color(0xFF64707A),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '\$${formatNumber(walletModel.balance)}',
                textAlign: TextAlign.right,
                style: AppStyles.getSemiBoldMono14(
                  context: context,
                  fontSize: AppSize.s20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
