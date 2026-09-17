import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/core/utils/constant.dart';
import 'package:fintrack/features/budgets/domain/models/available_category_with_spending.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BadgetPreviewCardWidget extends StatelessWidget {
  const new({
    super.key,
    required this.appContext,
    required this.availableCategoryWithSpending,
    required this.percentage,
    required this.budgetLimitedMonthlyStr,
  });

  final AppContext appContext;
  final AvailableCategoryWithSpending? availableCategoryWithSpending;
  final double? percentage;
  final String budgetLimitedMonthlyStr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p16),
      decoration: ShapeDecoration(
        color: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appContext.localText.previwe,
            style: AppStyles.getRegularSens14(
              context: context,
              fontSize: AppSize.s18,
              color: AppColors.white,
            ),
          ),
          const Gap(AppSize.s5),
          Row(
            children: [
              Text(
                appContext.localText.budg,
                style: AppStyles.getSemiBoldSens16(
                  context: context,
                  fontSize: AppSize.s24,
                  color: AppColors.white,
                ),
              ),
              const Gap(AppSize.s5),
              Text(
                availableCategoryWithSpending?.name ?? "",
                style: AppStyles.getSemiBoldSens16(
                  context: context,
                  fontSize: AppSize.s24,
                  color: AppColors.white,
                ),
              ),
              const Spacer(),
              Text(
                appContext.localText.monthly,
                style: AppStyles.getRegularSens14(
                  context: context,
                  fontSize: AppSize.s18,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          const Gap(AppSize.s12),
          LinearProgressIndicator(
            backgroundColor: AppColors.white.withValues(alpha: 0.20),
            color: AppColors.white,
            minHeight: AppSize.s12,
            borderRadius: BorderRadius.circular(AppSize.s16),
            value: percentage ?? 0,
          ),
          const Gap(AppSize.s8),
          Row(
            children: [
              Text(
                '\$${formatNumber(availableCategoryWithSpending?.spentThisMonth ?? 0)}',
                textAlign: TextAlign.right,
                style: AppStyles.getRegularSens10(
                  context: context,
                  fontSize: AppSize.s18,
                  color: AppColors.white,
                ),
              ),
              const Gap(AppSize.s8),
              Text(
                appContext.localText.expense,
                textAlign: TextAlign.right,
                style: AppStyles.getRegularSens10(
                  context: context,
                  fontSize: AppSize.s18,
                  color: AppColors.white,
                ),
              ),
              const Spacer(),
              Text(
                appContext.localText.limte,
                textAlign: TextAlign.right,
                style: AppStyles.getRegularSens10(
                  context: context,
                  fontSize: AppSize.s18,
                  color: AppColors.white,
                ),
              ),
              const Gap(AppSize.s18),
              Text(
                '${formatNumber(double.parse(budgetLimitedMonthlyStr))}\$',
                textAlign: TextAlign.right,
                style: AppStyles.getRegularSens10(
                  context: context,
                  fontSize: AppSize.s18,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
