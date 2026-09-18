import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class BalanceCardWidget extends StatelessWidget {
  final double totalBalance;
  final List<WalletsTableData> wallets;
  final bool isTrendUp;
  final double trendPercentage;

  const BalanceCardWidget({
    super.key,
    required this.totalBalance,
    required this.wallets,
    required this.isTrendUp,
    required this.trendPercentage,
  });

  @override
  Widget build(BuildContext context) {
    final appContxt = AppContext.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.tealark],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appContxt.localText.total_balance,
            style: AppStyles.getRegularSens10(
              context: context,
              color: Colors.white.withValues(alpha: 0.70),
              fontSize: AppSize.s16,
            ),
          ),
          const Gap(AppSize.s8),
          Text(
            '\$${formatNumber(totalBalance)}',
            style: AppStyles.getSemiBoldMono30(
              context: context,
              color: Colors.white,
              fontSize: AppSize.s36,
            ),
          ),
          const Gap(AppSize.s8),
          Text(
            appContxt.localText.account,
            style: AppStyles.getRegularSens10(
              context: context,
              color: Colors.white.withValues(alpha: 0.70),
              fontSize: AppSize.s16,
            ),
          ),
          const Gap(AppSize.s5),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: wallets.map((w) {
                return Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.white.withValues(alpha: 0.12),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icon/${w.iconName}.svg",
                        height: AppSize.s18,
                        width: AppSize.s18,
                        colorFilter: ColorFilter.mode(AppColors.white.withValues(alpha: 0.85), BlendMode.srcIn),
                      ),
                      const Gap(AppSize.s8),
                      Text(
                        w.name,
                        style: AppStyles.getRegularSens10(
                          context: context,
                          color: Colors.white.withValues(alpha: 0.90),
                          fontSize: AppSize.s14,
                        ),
                      ),
                      const Gap(AppSize.s8),
                      Text(
                        '\$${formatNumber(w.balance)}',
                        style: AppStyles.getRegularMono12(
                          context: context,
                          color: Colors.white,
                          fontSize: AppSize.s14,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
