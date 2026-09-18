import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/presentaion/screens/add_transaction_sheet_screen.dart';
import 'package:fintrack/core/presentaion/widgets/custom_bottom_nav_bar.dart';
import 'package:fintrack/di/injection.dart';
import 'package:fintrack/features/accounts/presentaion/screens/accounts_screen.dart';
import 'package:fintrack/features/budgets/presentaion/screens/budgets_screen.dart';
import 'package:fintrack/features/home/presentaion/screens/home_screen.dart';
import 'package:fintrack/features/main/presentaion/state_manege/bloc/main_bloc.dart';
import 'package:fintrack/features/main/presentaion/state_manege/bloc/main_event.dart';
import 'package:fintrack/features/main/presentaion/state_manege/bloc/main_state.dart';
import 'package:fintrack/features/reports/presentaion/screens/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final List<Widget> _pages;
  @override
  void initState() {
    _pages = [
      HomeScreen(),
      AccountsScreen(),
      BudgetsScreen(),
      ReportScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          final bloc = context.read<MainBloc>();
          return Scaffold(
            body: _pages[state.currntIndex],
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: state.currntIndex,
              onItemSelected: (selctedIndex) {
                bloc.add(ChangeTabEvent(selctIndex: selctedIndex));
              },
              onAddPressed: () async {
                final db = getIt<AppDatabase>();

                final accounts = await db.select(db.walletsTable).get();

                if (accounts.isEmpty) {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s16)),
                      content: Text(
                        'يرجى إضافة حساب أولاً',
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

                  return;
                }

                if (!context.mounted) return;

                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => AddTransactionSheetScreen(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
