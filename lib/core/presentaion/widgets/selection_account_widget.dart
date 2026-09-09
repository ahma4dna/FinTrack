import 'package:fintrack/core/application/resource/app_assets.dart';
import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/presentaion/widgets/selected_wallet_sheet_screen.dart';
import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SelectionAccountWidget extends StatelessWidget {
  const SelectionAccountWidget({
    super.key,
    required this.walletModel,
    required this.onWalletSelected,
  });

  final WalletModel? walletModel;
  final void Function(WalletModel) onWalletSelected;
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
        onTap: () async {
          final wallet = await showModalBottomSheet<WalletModel>(
            isDismissible: false,
            enableDrag: false,
            context: context,
            builder: (context) {
              return SelectedWalletSheetScreen();
            },
          );

          if (wallet != null) {
            onWalletSelected(wallet);
          }
        },
        child: Row(
          children: [
            Container(
              width: AppSize.s44,
              height: AppSize.s44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightBackground,
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.cash,
                  width: AppSize.s25,
                  height: AppSize.s25,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const Gap(AppSize.s10),
            if (walletModel == null) ...[
              Text(
                "اختر حساب",
                style: AppStyles.getMeduimSens14(
                  context: context,
                  fontSize: AppSize.s18,
                  color: Color(0xFF121820),
                ),
              ),
            ] else ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    walletModel?.name ?? "",
                    style: AppStyles.getMeduimSens14(
                      context: context,
                      fontSize: AppSize.s16,
                      color: Color(0xFF121820),
                    ),
                  ),

                  Text(
                    'الرصيد: \$${walletModel?.balance.toString()}',
                    style: AppStyles.getRegularSens10(
                      context: context,
                      fontSize: AppSize.s14,
                      color: Color(0xFF64707A),
                    ),
                  ),
                ],
              ),
            ],
            //selct date

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
