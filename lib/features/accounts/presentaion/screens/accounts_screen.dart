import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/features/accounts/presentaion/widgets/account_card_widget.dart';
import 'package:fintrack/features/accounts/presentaion/widgets/add_new_account_widget.dart';
import 'package:fintrack/features/accounts/presentaion/widgets/total_accounts_widgt.dart';
import 'package:fintrack/features/accounts/routes/accounts_path.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AccountsScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final AppContext appContext = AppContext.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TotalAccountsWidgt(appContext: appContext),
            const Gap(AppSize.s25),

            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: AppPadding.p12),
                  child: AccountCardWidget(),
                ),
              ),
            ),
            const Gap(AppSize.s25),

            AddNewAccountWidget(
              onTap: () {
                context.push("$accountsPath/$addNewaccountPathe");
              },
            ),
            const Gap(AppSize.s20),
          ],
        ),
      ),
    );
  }
}
