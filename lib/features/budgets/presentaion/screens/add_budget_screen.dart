import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/presentaion/widgets/category_widget.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/di/injection.dart';
import 'package:fintrack/features/budgets/domain/models/available_category_with_spending.dart';
import 'package:fintrack/features/budgets/presentaion/state_manege/bloc/budgets_bloc.dart';
import 'package:fintrack/features/budgets/presentaion/state_manege/bloc/budgets_event.dart';
import 'package:fintrack/features/budgets/presentaion/state_manege/bloc/budgets_state.dart';
import 'package:fintrack/features/budgets/presentaion/widgets/badget_preview_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({super.key});

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  late TextEditingController? budgetLimitedMonthly;
  int selctCate = 0;
  String? budgetLimitedMonthlyStr = "0";
  AvailableCategoryWithSpending? availableCategoryWithSpending;
  double? percentage;
  @override
  void initState() {
    budgetLimitedMonthly = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    budgetLimitedMonthly?.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appContext = AppContext.of(context);
    return Scaffold(
      appBar: myScreenAppBar(appContext, context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p20,
        ),
        child: BlocProvider.value(
          value: getIt<BudgetsBloc>()..add(GetAvailableCategoriesEvent()),
          child: BlocBuilder<BudgetsBloc, BudgetsState>(
            builder: (context, state) {
              if (state.availableCategoryWithSpending.isEmpty) {
                return CircularProgressIndicator(
                  color: AppColors.primary,
                );
              }
              availableCategoryWithSpending = state.availableCategoryWithSpending.first;
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        appContext.localText.limte_budget,
                        style: AppStyles.getMeduimSens12(
                          context: context,
                          fontSize: AppSize.s16,
                          color: Color(0xFF64707A),
                        ),
                      ),
                    ),
                    const Gap(AppSize.s8),
                    SizedBox(
                      height: AppSize.s60,
                      child: TextField(
                        onChanged: (value) {
                          budgetLimitedMonthlyStr = value.isEmpty ? "0" : value;

                          final limit = double.tryParse(budgetLimitedMonthlyStr!) ?? 0;
                          final spent = availableCategoryWithSpending?.spentThisMonth ?? 0;

                          setState(() {
                            percentage = limit > 0 ? (spent / limit).clamp(0.0, 1.0) : 0.0;
                          });
                        },
                        keyboardType: TextInputType.number,
                        controller: budgetLimitedMonthly,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: AppStyles.getRegularSens10(
                          context: context,
                          fontSize: AppSize.s24,
                        ),
                      ),
                    ),
                    const Gap(AppSize.s20),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        appContext.localText.selct_category,
                        style: AppStyles.getMeduimSens12(
                          context: context,
                          fontSize: AppSize.s16,
                          color: Color(0xFF64707A),
                        ),
                      ),
                    ),
                    const Gap(AppSize.s8),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: AppSize.s8,
                        runSpacing: AppSize.s8,
                        children: List.generate(
                          state.availableCategoryWithSpending.length,
                          (index) => CategoryWidget(
                            isVisbaleSelectedIcon: false,
                            catNmae: state.availableCategoryWithSpending[index].name,
                            icon: state.availableCategoryWithSpending[index].iconName,
                            selctedCat: selctCate,
                            onTap: () {
                              final selected = state.availableCategoryWithSpending[index];
                              final limit = double.tryParse(budgetLimitedMonthlyStr ?? "0") ?? 0;
                              setState(() {
                                selctCate = index;
                                availableCategoryWithSpending = selected;
                                percentage = limit > 0 ? (selected.spentThisMonth / limit).clamp(0.0, 1.0) : 0.0;
                              });
                            },
                            index: index,
                          ),
                        ),
                      ),
                    ),
                    const Gap(AppSize.s8),
                    BadgetPreviewCardWidget(
                      appContext: appContext,
                      availableCategoryWithSpending: availableCategoryWithSpending,
                      percentage: percentage,
                      budgetLimitedMonthlyStr: budgetLimitedMonthlyStr ?? "0",
                    ),
                    const Gap(AppSize.s24),
                    ElevatedButton(
                      onPressed: () {
                        if (double.parse(budgetLimitedMonthlyStr ?? "0") > 0) {
                          getIt<BudgetsBloc>().add(
                            InsertBudgetsEvent(
                              budget: BudgetsTableCompanion.insert(
                                categoryId: availableCategoryWithSpending?.categoryId ?? 0,
                                limitAmount: double.parse(budgetLimitedMonthlyStr ?? "0"),
                              ),
                            ),
                          );

                          context.pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s16)),
                              content: Text(
                                'يرجى إضافة قيمة أولاً',
                                style: AppStyles.getRegularSens14(
                                  context: context,
                                  fontSize: AppSize.s18,
                                  color: AppColors.white,
                                ),
                              ),
                              backgroundColor: AppColors.black,
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.symmetric(
                                horizontal: AppPadding.p20,
                              ),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppPadding.p14),
                        child: Text(
                          appContext.localText.save_budget,
                          style: AppStyles.getSemiBoldSens16(
                            context: context,
                            fontSize: AppSize.s22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  AppBar myScreenAppBar(AppContext appContext, BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: AppColors.border,
        ),
      ),
      backgroundColor: AppColors.white,
      title: Text(
        appContext.localText.add_budget,
        style: AppStyles.getSemiBoldSens16(
          context: context,
          fontSize: AppSize.s18,
        ),
      ),
      centerTitle: false,
    );
  }
}
