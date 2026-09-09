import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/presentaion/widgets/header_selction_accounts_widget.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/di/injection.dart';
import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';
import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_bloc.dart';
import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_event.dart';
import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_state.dart';
import 'package:fintrack/features/accounts/presentaion/widgets/account_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SelectedWalletSheetScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SelectedWalletSheetScreen> createState() => _SelectedWalletSheetScreenState();
}

class _SelectedWalletSheetScreenState extends State<SelectedWalletSheetScreen> {
  int selctIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AccountsBloc>()..add(WatchWalletsEvent()),
      child: BlocBuilder<AccountsBloc, AccountsState>(
        builder: (context, state) {
          if (state.wallestModel.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          WalletModel selectedWalletModel = state.wallestModel[selctIndex];
          final AppContext appContext = AppContext.of(context);
          return Container(
            height: MediaQuery.sizeOf(context).height * AppSize.s0_8,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s24),
                topRight: Radius.circular(AppSize.s24),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p24,
              vertical: AppPadding.p30,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HeaderSelctionAccountsWidget(
                  appContext: appContext,
                  onTapPop: () => Navigator.pop(context, state.wallestModel.first),
                ),
                const Gap(AppSize.s20),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.wallestModel.length,
                    itemBuilder: (context, index) {
                      bool isSelcted = selctIndex == index;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppPadding.p12),
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(AppSize.s16),
                              side: isSelcted
                                  ? BorderSide(
                                      width: 2,
                                      color: AppColors.primary,
                                    )
                                  : BorderSide.none,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              selctIndex = index;
                              selectedWalletModel = state.wallestModel[index];
                              setState(() {});
                            },
                            child: AccountCardWidget(
                              walletModel: state.wallestModel[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Gap(AppSize.s40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(
                      AppPadding.p16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, selectedWalletModel);
                  },
                  child: Text(
                    appContext.localText.save_transaction,
                    style: AppStyles.getSemiBoldSens16(
                      context: context,
                      fontSize: AppSize.s18,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const Gap(AppSize.s20),
              ],
            ),
          );
        },
      ),
    );
  }
}
