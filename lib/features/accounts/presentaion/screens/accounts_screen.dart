import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/di/injection.dart';
import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_bloc.dart';
import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_event.dart';
import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_state.dart';
import 'package:fintrack/features/accounts/presentaion/widgets/account_card_widget.dart';
import 'package:fintrack/features/accounts/presentaion/widgets/add_new_account_widget.dart';
import 'package:fintrack/features/accounts/presentaion/widgets/total_accounts_widgt.dart';
import 'package:fintrack/features/accounts/routes/accounts_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AccountsScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final AppContext appContext = AppContext.of(context);
    return BlocProvider.value(
      value: getIt<AccountsBloc>()..add(WatchWalletsEvent()),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
          ),
          child: BlocBuilder<AccountsBloc, AccountsState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TotalAccountsWidgt(
                    appContext: appContext,
                    walletsModel: state.wallestModel,
                  ),
                  const Gap(AppSize.s25),
                  Expanded(
                    child: state.wallestModel.isEmpty
                        ? Center(
                            child: Text(
                              AppContext.of(context).localText.not_add_account,
                              style: AppStyles.getMeduimSens14(
                                context: context,
                                fontSize: AppSize.s22,
                                color: AppColors.black,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.wallestModel.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: AppPadding.p12),
                              child: AccountCardWidget(
                                walletModel: state.wallestModel[index],
                              ),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
