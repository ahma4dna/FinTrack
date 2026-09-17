import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/di/injection.dart';
import 'package:fintrack/features/budgets/presentaion/state_manege/bloc/budgets_bloc.dart';
import 'package:fintrack/features/budgets/presentaion/state_manege/bloc/budgets_event.dart';
import 'package:fintrack/features/budgets/presentaion/state_manege/bloc/budgets_state.dart';
import 'package:fintrack/features/budgets/presentaion/widgets/budgt_widget.dart';
import 'package:fintrack/features/budgets/presentaion/widgets/header_budget_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BudgetsScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final appContext = AppContext.of(context);
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: BlocProvider.value(
          value: getIt<BudgetsBloc>()
            ..add(WatchBudgetsEvent())
            ..add(GetAvailableCategoriesEvent()),
          child: BlocBuilder<BudgetsBloc, BudgetsState>(
            builder: (context, state) {
              return Column(
                children: [
                  HeaderBudgetWidget(
                    appContext: appContext,
                    budgetsState: state,
                  ),
                  const Gap(AppSize.s24),
                  if (state.budgetWithSpending.isEmpty) ...[
                    Expanded(
                      child: Center(
                        child: Text(
                          appContext.localText.not_budgets,
                          textAlign: TextAlign.right,
                          style: AppStyles.getMeduimSens14(
                            fontSize: AppSize.s18,
                            context: context,
                            color: const Color(0xFF121820),
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.budgetWithSpending.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppPadding.p12,
                            ),
                            child: BudgtWidget(
                              appContext: appContext,
                              budgetWithSpending: state.budgetWithSpending[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
