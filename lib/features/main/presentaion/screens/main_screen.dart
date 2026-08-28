import 'package:fintrack/core/presentaion/widgets/custom_bottom_nav_bar.dart';
import 'package:fintrack/features/accounts/presentaion/screens/accounts_screen.dart';
import 'package:fintrack/features/budgets/presentaion/screens/budgets_screen.dart';
import 'package:fintrack/features/home/presentaion/screens/home_screen.dart';
import 'package:fintrack/features/main/presentaion/state_manege/bloc/main_bloc.dart';
import 'package:fintrack/features/main/presentaion/state_manege/bloc/main_event.dart';
import 'package:fintrack/features/main/presentaion/state_manege/bloc/main_state.dart';
import 'package:fintrack/features/reports/routes/reports_screen.dart';
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
      ReportsScreen(),
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
              onAddPressed: () {},
            ),
          );
        },
      ),
    );
  }
}
