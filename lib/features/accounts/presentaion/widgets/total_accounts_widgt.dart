import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TotalAccountsWidgt extends StatelessWidget {
  const TotalAccountsWidgt({
    super.key,
    required this.appContext,
    required this.walletsModel,
  });

  final AppContext appContext;
  final List<WalletModel> walletsModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appContext.localText.account,
          style: AppStyles.getSemiBoldSens20(
            context: context,
            fontSize: AppSize.s25,
          ),
        ),
        const Gap(AppSize.s5),
        Row(
          children: [
            Text(
              "الإجمالي",
              style: AppStyles.getRgularMono14(
                context: context,
                fontSize: AppSize.s18,
              ),
            ),
            Gap(AppSize.s5),
            Text(
              "\$",
              style: AppStyles.getRgularMono14(
                context: context,
                fontSize: AppSize.s18,
              ),
            ),

            Text(
              walletsModel.fold<double>(0, (sum, item) => sum + item.balance).toString(),
              style: AppStyles.getRgularMono14(
                context: context,
                fontSize: AppSize.s18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
