import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/features/budgets/domain/models/budget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeBudgetsWidget extends StatelessWidget {
  final List<BudgetWithSpending> budgets;

  const HomeBudgetsWidget({super.key, required this.budgets});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: budgets.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final b = budgets[index];
          final limit = b.budget.limitAmount;
          final pct = limit > 0 ? ((b.spent / limit) * 100).clamp(0, 100) : 0.0;

          return Container(
            width: 140,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.white,
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.lightBackground,
                      ),
                      height: AppSize.s30,
                      width: AppSize.s30,
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icon/${b.categoryIcon}.svg",
                          height: AppSize.s18,
                          width: AppSize.s18,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(Color(0XFF121820), BlendMode.srcIn),
                        ),
                      ),
                    ),
                    const Gap(AppSize.s8),
                    Expanded(
                      child: Text(
                        b.categoryName,
                        style: AppStyles.getMeduimSens12(
                          context: context,
                          color: const Color(0xFF121820),
                          fontSize: AppSize.s14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                LinearProgressIndicator(
                  value: pct / 100,
                  color: Color(int.parse(b.categoryColor)),
                  backgroundColor: AppColors.lightBackground,
                  borderRadius: BorderRadius.circular(999),
                  minHeight: AppSize.s8,
                ),

                const Gap(AppSize.s8),
                Text(
                  '\$${b.spent.toInt()} / \$${limit.toInt()}',
                  style: AppStyles.getRegularMono12(
                    context: context,
                    color: const Color(0xFF64707A),
                    fontSize: AppSize.s14,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
