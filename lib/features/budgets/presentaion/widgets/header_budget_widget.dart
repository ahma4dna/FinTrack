import 'package:fintrack/core/application/resource/app_assets.dart';
import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/features/budgets/presentaion/state_manege/bloc/budgets_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HeaderBudgetWidget extends StatelessWidget {
  const HeaderBudgetWidget({
    super.key,
    required this.appContext,
    required this.budgetsState,
  });

  final AppContext appContext;
  final BudgetsState budgetsState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appContext.localText.budgets_monthly,
          style: AppStyles.getSemiBoldSens20(
            context: context,
            fontSize: AppSize.s24,
          ),
        ),
        if (budgetsState.availableCategoryWithSpending.isNotEmpty)
          InkWell(
            onTap: () => context.pushNamed("add-budget"),
            child: Container(
              width: AppSize.s45,
              height: AppSize.s45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.add,
                  width: AppSize.s25,
                  height: AppSize.s25,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
