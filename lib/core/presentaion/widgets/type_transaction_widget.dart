import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TypeTransactionWidget extends StatelessWidget {
  final AppContext appContext;
  final void Function() selctionTypeTranactionIncome;
  final void Function() selctionTypeTranactionExpense;
  final String selctionTypeTranaction;
  const TypeTransactionWidget({
    super.key,
    required this.appContext,
    required this.selctionTypeTranactionIncome,
    required this.selctionTypeTranactionExpense,
    required this.selctionTypeTranaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p5),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: selctionTypeTranactionExpense,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                padding: EdgeInsets.all(AppPadding.p5),
                decoration: BoxDecoration(
                  color: selctionTypeTranaction != "expense" ? AppColors.lightBackground : AppColors.white,
                  borderRadius: BorderRadius.circular(AppSize.s6),
                ),
                child: Center(
                  child: Text(
                    appContext.localText.expense,
                    style: AppStyles.getMeduimSens14(
                      context: context,
                      fontSize: AppSize.s22,
                      color: const Color(0xFF121820),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Gap(AppSize.s5),
          Expanded(
            child: InkWell(
              onTap: selctionTypeTranactionIncome,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                padding: EdgeInsets.all(AppPadding.p5),
                decoration: BoxDecoration(
                  color: selctionTypeTranaction != "income" ? AppColors.lightBackground : AppColors.white,
                  borderRadius: BorderRadius.circular(AppSize.s6),
                ),
                child: Center(
                  child: Text(
                    appContext.localText.income,
                    style: AppStyles.getMeduimSens14(
                      context: context,
                      fontSize: AppSize.s22,
                      color: const Color(0xFF121820),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
