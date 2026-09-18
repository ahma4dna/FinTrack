import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/domain/models/transaction_with_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeTransactionsWidget extends StatelessWidget {
  final List<TransactionWithDetails> transactions;

  const HomeTransactionsWidget({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: transactions.map((tx) {
          final isIncome = tx.transaction.type == 'income';
          final sign = isIncome ? '+' : '-';
          final amountColor = isIncome ? AppColors.moss : AppColors.black;

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.lightSurface,
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Container(
                  width: AppSize.s45,
                  height: AppSize.s45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightBackground,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icon/${tx.categoryIcon}.svg",
                      width: AppSize.s20,
                      height: AppSize.s20,
                      colorFilter: ColorFilter.mode(Color(int.parse(tx.categoryColor)), BlendMode.srcIn),
                    ),
                  ),
                ),
                const Gap(AppSize.s12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.transaction.title,
                        style: AppStyles.getMeduimSens14(
                          context: context,
                          color: const Color(0xFF121820),
                          fontSize: AppSize.s16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        tx.walletName,
                        style: AppStyles.getRegularSens10(
                          context: context,
                          color: const Color(0xFF64707A),
                          fontSize: AppSize.s14,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '$sign\$${tx.transaction.amount.toStringAsFixed(0)}',
                  style: AppStyles.getSemiBoldMono14(
                    context: context,
                    color: amountColor,
                    fontSize: AppSize.s16,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
