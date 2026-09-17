import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/presentaion/state_mangement/bloc/transacation_bloc.dart';
import 'package:fintrack/core/presentaion/state_mangement/bloc/transacation_event.dart';
import 'package:fintrack/core/presentaion/state_mangement/bloc/transacation_state.dart';
import 'package:fintrack/core/presentaion/widgets/add_tranaction_button_widget.dart';
import 'package:fintrack/core/presentaion/widgets/amount_faild_widget.dart';
import 'package:fintrack/core/presentaion/widgets/category_widget.dart';
import 'package:fintrack/core/presentaion/widgets/header_trnasaction_widget.dart';
import 'package:fintrack/core/presentaion/widgets/note_faild_widget.dart';
import 'package:fintrack/core/presentaion/widgets/note_title_widget.dart';
import 'package:fintrack/core/presentaion/widgets/selcted_date_widget.dart';
import 'package:fintrack/core/presentaion/widgets/selection_account_widget.dart';
import 'package:fintrack/core/presentaion/widgets/title_feaild_widget.dart';
import 'package:fintrack/core/presentaion/widgets/title_widget_right.dart';
import 'package:fintrack/core/presentaion/widgets/type_transaction_widget.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/di/injection.dart';
import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AddTransactionSheetScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<AddTransactionSheetScreen> createState() => _AddTransactionSheetScreenState();
}

class _AddTransactionSheetScreenState extends State<AddTransactionSheetScreen> {
  late TextEditingController amount;
  late TextEditingController title;
  late TextEditingController note;
  String selctionTypeTranaction = "expense";
  int selctCate = 0;
  String selctCateValue = "food";
  WalletModel? walletModel;
  DateTime? selctDate;
  CategoriesTableData? categoriesTableData;
  Future<void> pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        selctDate = date;
      });
    }
  }

  @override
  void initState() {
    amount = TextEditingController();
    title = TextEditingController();
    note = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    amount.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appContext = AppContext.of(context);
    return BlocProvider(
      create: (context) => getIt<TransacationBloc>()..add(GetCategoryEvent()),
      child: BlocBuilder<TransacationBloc, TransacationState>(
        builder: (context, state) {
          if (state.categoriesTableData.isEmpty) {
            return CircularProgressIndicator(
              color: AppColors.primary,
            );
          }
          categoriesTableData ??= state.categoriesTableData.first;
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
                HeaderTrnasactionWidget(appContext: appContext),
                const Gap(AppSize.s22),
                TypeTransactionWidget(
                  appContext: appContext,
                  selctionTypeTranactionIncome: () {
                    selctionTypeTranaction = "income";
                    setState(() {});
                  },
                  selctionTypeTranactionExpense: () {
                    selctionTypeTranaction = "expense";
                    setState(() {});
                  },
                  selctionTypeTranaction: selctionTypeTranaction,
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Gap(AppSize.s20),
                        Text(
                          appContext.localText.price,
                          style: AppStyles.getMeduimSens12(
                            context: context,
                            fontSize: AppSize.s16,
                            color: Color(0xFF64707A),
                          ),
                        ),
                        const Gap(AppSize.s5),
                        AmountFaildWidget(amount: amount),
                        const Gap(AppSize.s20),
                        TitleWidgetRight(
                          appContext: appContext,
                          text: appContext.localText.data,
                        ),
                        const Gap(AppSize.s8),
                        SelctedDateWidget(
                          selctDate: selctDate,
                          pickDate: pickDate,
                        ),
                        const Gap(AppSize.s20),
                        TitleWidgetRight(appContext: appContext, text: appContext.localText.account_from),
                        const Gap(AppSize.s8),
                        SelectionAccountWidget(
                          walletModel: walletModel,
                          onWalletSelected: (WalletModel p1) {
                            walletModel = p1;
                            setState(() {});
                          },
                        ),
                        const Gap(AppSize.s20),
                        TitleWidgetRight(appContext: appContext, text: appContext.localText.addres),
                        const Gap(AppSize.s8),
                        TitleFeaildWidget(title: title, appContext: appContext),
                        const Gap(AppSize.s20),
                        TitleWidgetRight(appContext: appContext, text: appContext.localText.category),
                        const Gap(AppSize.s8),
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            spacing: AppSize.s8,
                            runSpacing: AppSize.s8,
                            children: List.generate(
                              state.categoriesTableData.length,
                              (index) => CategoryWidget(
                                catNmae: state.categoriesTableData[index].name,
                                icon: state.categoriesTableData[index].iconName,
                                selctedCat: selctCate,
                                onTap: () {
                                  selctCate = index;
                                  categoriesTableData = state.categoriesTableData[index];
                                  setState(() {});
                                },
                                index: index,
                              ),
                            ),
                          ),
                        ),
                        const Gap(AppSize.s20),
                        NoteTitleWidget(appContext: appContext),
                        const Gap(AppSize.s8),
                        NoteFaildWidget(note: note, appContext: appContext),
                        const Gap(AppSize.s20),
                        AddTranactionButtonWidget(
                          appContext: appContext,
                          onPressed: () {
                            final txn = TransactionsTableCompanion.insert(
                              walletId: walletModel?.id ?? 0,
                              categoryId: categoriesTableData?.id ?? 0,
                              type: selctionTypeTranaction,
                              amount: double.parse(amount.text),
                              title: title.text,
                              date: selctDate ?? DateTime.now(),
                            );
                            if (walletModel != null && categoriesTableData != null) {
                              getIt<TransacationBloc>().add(
                                AddTranactionEvnt(
                                  txn: txn,
                                ),
                              );
                              context.pop();
                            }
                          },
                        ),
                      ],
                    ),
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
