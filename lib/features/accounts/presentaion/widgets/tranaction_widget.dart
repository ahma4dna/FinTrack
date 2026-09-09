import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/domain/models/transaction_with_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class TranactionWidget extends StatelessWidget {
  final TransactionWithDetails transactionWithDetails;
  const TranactionWidget({
    super.key,
    required this.transactionWithDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.s12,
        vertical: AppSize.s14,
      ),
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          side: BorderSide(
            width: 1,
            color: AppColors.border,
          ),
        ),
      ),
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
                "assets/icon/${transactionWithDetails.categoryIcon}.svg",
                width: AppSize.s20,
                height: AppSize.s20,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Color(int.parse(transactionWithDetails.categoryColor)), BlendMode.srcIn),
              ),
            ),
          ),

          const Gap(AppSize.s10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transactionWithDetails.transaction.title,
                style: AppStyles.getMeduimSens14(
                  context: context,
                  fontSize: AppSize.s16,
                  color: Color(0xFF121820),
                ),
              ),

              Text(
                transactionWithDetails.walletName,
                style: AppStyles.getRegularSens10(
                  context: context,
                  fontSize: AppSize.s14,
                  color: Color(0xFF64707A),
                ),
              ),
            ],
          ),
          //selct date

          const Spacer(),
          Row(
            children: [
              Text(
                transactionWithDetails.transaction.type != "expense" ? "+" : "-",
                style: AppStyles.getSemiBoldMono14(
                  context: context,
                  fontSize: AppSize.s20,
                  color: transactionWithDetails.transaction.type != "expense" ? Color(0xFF4C9A6A) : Color(0XFF121820),
                ),
              ),
              Text(
                "\$${transactionWithDetails.transaction.amount.toString()}",
                style: AppStyles.getSemiBoldMono14(
                  context: context,
                  fontSize: AppSize.s18,
                  color: transactionWithDetails.transaction.type != "expense" ? Color(0xFF4C9A6A) : Color(0XFF121820),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
