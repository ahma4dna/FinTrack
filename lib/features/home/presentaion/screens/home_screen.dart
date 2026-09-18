import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/di/injection.dart';
import 'package:fintrack/features/home/presentaion/widgets/balance_card_widget.dart';
import 'package:fintrack/features/home/presentaion/widgets/home_budgets_widget.dart';
import 'package:fintrack/features/home/presentaion/widgets/home_transactions_widget.dart';
import 'package:fintrack/features/home/presentaion/widgets/section_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/features/home/presentaion/state_manege/bloc/home_bloc.dart';
import 'package:fintrack/features/home/presentaion/state_manege/bloc/home_state.dart';
import 'package:fintrack/features/home/presentaion/state_manege/bloc/home_event.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<HomeBloc>()..add(WatchHomeDataEvent()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final appContext = AppContext.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.walletsData == null) {
          return const Scaffold(
            backgroundColor: AppColors.lightBackground,
            body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.lightBackground,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(AppSize.s20),
                BalanceCardWidget(
                  totalBalance: state.walletsData!.totalBalance,
                  wallets: state.walletsData!.wallets,
                  isTrendUp: true,
                  trendPercentage: 2.4,
                ),
                const Gap(AppSize.s24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.budgets.isNotEmpty) ...[
                          SectionHeaderWidget(
                            title: appContext.localText.budget,
                          ),
                          const Gap(AppSize.s12),
                          HomeBudgetsWidget(budgets: state.budgets),
                          const Gap(AppSize.s24),
                        ],
                        if (state.recentTransactions.isNotEmpty) ...[
                          SectionHeaderWidget(
                            title: appContext.localText.recent_transactions,
                          ),
                          const Gap(AppSize.s12),
                          HomeTransactionsWidget(transactions: state.recentTransactions),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
