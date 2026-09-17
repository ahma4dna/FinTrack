import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/core/utils/constant.dart';
import 'package:fintrack/features/budgets/domain/models/budget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class BudgtWidget extends StatelessWidget {
  final AppContext appContext;
  final BudgetWithSpending budgetWithSpending;
  const BudgtWidget({
    super.key,
    required this.budgetWithSpending,
    required this.appContext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p16),
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s16),
          side: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: AppSize.s40,
                height: AppSize.s40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightBackground,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icon/${budgetWithSpending.categoryIcon}.svg",
                    width: AppSize.s20,
                    height: AppSize.s20,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Color(0XFF121820), BlendMode.srcIn),
                  ),
                ),
              ),
              const Gap(AppSize.s8),
              Text(
                budgetWithSpending.categoryName,
                textAlign: TextAlign.right,
                style: AppStyles.getMeduimSens14(
                  fontSize: AppSize.s18,
                  context: context,
                  color: const Color(0xFF121820),
                ),
              ),
              const Spacer(),
              Text(
                '${budgetWithSpending.percentage}%',
                textAlign: TextAlign.right,
                style: AppStyles.getRegularMono12(
                  context: context,
                  fontSize: AppSize.s14,
                  color: Color(int.parse(budgetWithSpending.categoryColor)),
                ),
              ),
            ],
          ),
          const Gap(AppSize.s12),
          LinearProgressIndicator(
            value: budgetWithSpending.percentage / 100,
            backgroundColor: AppColors.lightBackground,
            color: Color(int.parse(budgetWithSpending.categoryColor)),
            minHeight: 12,
            borderRadius: BorderRadius.circular(AppSize.s20),
          ),
          const Gap(AppSize.s8),
          Row(
            children: [
              Text(
                '\$${formatNumber(budgetWithSpending.spent)}',
                textAlign: TextAlign.right,
                style: AppStyles.getRegularMono12(
                  context: context,
                  fontSize: AppSize.s14,
                  color: const Color(0xFF64707A),
                ),
              ),
              const Gap(AppSize.s8),
              Text(
                appContext.localText.expense,
                textAlign: TextAlign.right,
                style: AppStyles.getRegularMono12(
                  context: context,
                  fontSize: AppSize.s14,
                  color: const Color(0xFF64707A),
                ),
              ),
              const Spacer(),
              Text(
                appContext.localText.limte,
                textAlign: TextAlign.right,
                style: AppStyles.getRegularMono12(
                  context: context,
                  fontSize: AppSize.s14,
                  color: const Color(0xFF64707A),
                ),
              ),
              const Gap(AppSize.s18),
              Text(
                '${formatNumber(budgetWithSpending.limitAmount)}\$',
                textAlign: TextAlign.right,
                style: AppStyles.getRegularMono12(
                  context: context,
                  fontSize: AppSize.s14,
                  color: const Color(0xFF64707A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
