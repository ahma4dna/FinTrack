import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/presentaion/state_mangement/bloc/transacation_bloc.dart';
import 'package:fintrack/core/presentaion/state_mangement/bloc/transacation_event.dart';
import 'package:fintrack/core/presentaion/state_mangement/bloc/transacation_state.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/di/injection.dart';
import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';
import 'package:fintrack/features/accounts/presentaion/widgets/tranaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class TransactionWalletScreen extends StatelessWidget {
  final WalletModel walletModel;
  const TransactionWalletScreen({
    super.key,
    required this.walletModel,
  });

  @override
  @override
  Widget build(BuildContext context) {
    final AppContext appContext = AppContext.of(context);
    return BlocProvider(
      create: (context) => getIt<TransacationBloc>()..add(WatchByWalletTranactionEvnt(walletId: walletModel.id ?? 0)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios_new, size: AppSize.s26),
          ),
          title: Text(
            appContext.localText.all_tranactions,
            style: AppStyles.getSemiBoldSens16(context: context, fontSize: AppSize.s18),
          ),
        ),
        body: BlocBuilder<TransacationBloc, TransacationState>(
          builder: (context, state) {
            if (state.categoriesTableData.isNotEmpty) {
              print(state.categoriesTableData.first.iconName);
            }
            return Column(
              children: [
                const Gap(AppSize.s20),
                Expanded(
                  child: state.transactionWithDetails.isEmpty
                      ? Center(
                          child: Text(
                            AppContext.of(context).localText.no_traactions,
                            style: AppStyles.getMeduimSens14(
                              context: context,
                              fontSize: AppSize.s22,
                              color: AppColors.black,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: state.transactionWithDetails.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppPadding.p12,
                              left: AppPadding.p12,
                              right: AppPadding.p12,
                            ),
                            child: InkWell(
                              child: TranactionWidget(
                                transactionWithDetails: state.transactionWithDetails[index],
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
