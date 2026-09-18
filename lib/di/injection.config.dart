// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:drift/drift.dart' as _i500;
import 'package:fintrack/core/data/dao/transactions_daos.dart' as _i721;
import 'package:fintrack/core/data/repository/transactions_repository_imp.dart'
    as _i980;
import 'package:fintrack/core/database/app_database.dart' as _i449;
import 'package:fintrack/core/domain/repository/transactions_repository.dart'
    as _i825;
import 'package:fintrack/core/domain/use_case/delete_transaction_use_case.dart'
    as _i1012;
import 'package:fintrack/core/domain/use_case/get_category_use_case.dart'
    as _i175;
import 'package:fintrack/core/domain/use_case/insert_transaction_use_case.dart'
    as _i278;
import 'package:fintrack/core/domain/use_case/watch_by_wallet_use_case.dart'
    as _i235;
import 'package:fintrack/core/presentaion/state_mangement/bloc/transacation_bloc.dart'
    as _i976;
import 'package:fintrack/features/accounts/data/dao/wallet_dao.dart' as _i688;
import 'package:fintrack/features/accounts/data/repository/wellets_repository_imp.dart'
    as _i94;
import 'package:fintrack/features/accounts/domain/repository/wellets_repository.dart'
    as _i820;
import 'package:fintrack/features/accounts/domain/use_case/insert_wallet_use_case.dart'
    as _i451;
import 'package:fintrack/features/accounts/domain/use_case/watch_wallets_use_case.dart'
    as _i359;
import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_bloc.dart'
    as _i554;
import 'package:fintrack/features/budgets/data/dao/budgets_dao.dart' as _i452;
import 'package:fintrack/features/budgets/data/repository/budgets_repository_imp.dart'
    as _i83;
import 'package:fintrack/features/budgets/domain/repository/budgets_repository.dart'
    as _i221;
import 'package:fintrack/features/budgets/domain/use_case/get_available_categories_use_case.dart'
    as _i898;
import 'package:fintrack/features/budgets/domain/use_case/insert_budget_use_case.dart'
    as _i252;
import 'package:fintrack/features/budgets/domain/use_case/watch_all_budget_use_case.dart'
    as _i566;
import 'package:fintrack/features/budgets/presentaion/state_manege/bloc/budgets_bloc.dart'
    as _i1029;
import 'package:fintrack/features/home/data/daos/home_dao.dart' as _i214;
import 'package:fintrack/features/home/data/repository/home_repository_impl.dart'
    as _i1019;
import 'package:fintrack/features/home/domain/repository/home_repository.dart'
    as _i121;
import 'package:fintrack/features/home/domain/use_case/watch_home_transactions_use_case.dart'
    as _i753;
import 'package:fintrack/features/home/domain/use_case/watch_home_wallets_use_case.dart'
    as _i95;
import 'package:fintrack/features/home/presentaion/state_manege/bloc/home_bloc.dart'
    as _i718;
import 'package:fintrack/features/reports/data/daos/report_daos.dart' as _i373;
import 'package:fintrack/features/reports/data/repository/report_repository_impl.dart'
    as _i24;
import 'package:fintrack/features/reports/domain/repository/report_repository.dart'
    as _i2;
import 'package:fintrack/features/reports/domain/use_case/get_category_spending_use_case.dart'
    as _i533;
import 'package:fintrack/features/reports/domain/use_case/get_weekly_trend_use_case.dart'
    as _i567;
import 'package:fintrack/features/reports/presentaion/state_manege/bloc/report_bloc.dart'
    as _i794;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final databaseModule = _$DatabaseModule();
    await gh.factoryAsync<_i500.QueryExecutor>(
      () => databaseModule.databaseConnection,
      preResolve: true,
    );
    gh.lazySingleton<_i449.AppDatabase>(
      () => _i449.AppDatabase(gh<_i500.QueryExecutor>()),
    );
    gh.lazySingleton<_i688.WalletDao>(
      () => databaseModule.walletDao(gh<_i449.AppDatabase>()),
    );
    gh.lazySingleton<_i721.TransactionsDaos>(
      () => databaseModule.transactionsDaos(gh<_i449.AppDatabase>()),
    );
    gh.lazySingleton<_i452.BudgetsDao>(
      () => databaseModule.budgetsDao(gh<_i449.AppDatabase>()),
    );
    gh.lazySingleton<_i373.ReportDaos>(
      () => databaseModule.reportDaos(gh<_i449.AppDatabase>()),
    );
    gh.lazySingleton<_i214.HomeDao>(
      () => databaseModule.hmeDao(gh<_i449.AppDatabase>()),
    );
    gh.lazySingleton<_i121.HomeRepository>(
      () => _i1019.HomeRepositoryImpl(homeDao: gh<_i214.HomeDao>()),
    );
    gh.lazySingleton<_i2.ReportRepository>(
      () => _i24.ReportRepositoryImpl(gh<_i373.ReportDaos>()),
    );
    gh.lazySingleton<_i825.TransactionsRepository>(
      () => _i980.TransactionsRepositoryImp(
        transactionsDaos: gh<_i721.TransactionsDaos>(),
      ),
    );
    gh.lazySingleton<_i1012.DeleteTransactionUseCase>(
      () => _i1012.DeleteTransactionUseCase(gh<_i825.TransactionsRepository>()),
    );
    gh.lazySingleton<_i175.GetCategoryUseCase>(
      () => _i175.GetCategoryUseCase(gh<_i825.TransactionsRepository>()),
    );
    gh.lazySingleton<_i278.InsertTransactionUseCase>(
      () => _i278.InsertTransactionUseCase(gh<_i825.TransactionsRepository>()),
    );
    gh.lazySingleton<_i235.WatchByWalletUseCase>(
      () => _i235.WatchByWalletUseCase(gh<_i825.TransactionsRepository>()),
    );
    gh.lazySingleton<_i95.WatchHomeWalletsUseCase>(
      () => _i95.WatchHomeWalletsUseCase(gh<_i121.HomeRepository>()),
    );
    gh.factory<_i753.WatchHomeTransactionsUseCase>(
      () => _i753.WatchHomeTransactionsUseCase(gh<_i121.HomeRepository>()),
    );
    gh.factory<_i976.TransacationBloc>(
      () => _i976.TransacationBloc(
        insertTransactionUseCase: gh<_i278.InsertTransactionUseCase>(),
        deleteTransactionUseCase: gh<_i1012.DeleteTransactionUseCase>(),
        watchByWalletUseCase: gh<_i235.WatchByWalletUseCase>(),
        getCategoryUseCase: gh<_i175.GetCategoryUseCase>(),
      ),
    );
    gh.lazySingleton<_i820.WelletsRepository>(
      () => _i94.WelletsRepositoryImp(walletDao: gh<_i688.WalletDao>()),
    );
    gh.lazySingleton<_i221.BudgetsRepository>(
      () => _i83.BudgetsRepositoryImp(budgetsDao: gh<_i452.BudgetsDao>()),
    );
    gh.lazySingleton<_i898.GetAvailableCategoriesUseCase>(
      () => _i898.GetAvailableCategoriesUseCase(gh<_i221.BudgetsRepository>()),
    );
    gh.lazySingleton<_i252.InsertBudgetUseCase>(
      () => _i252.InsertBudgetUseCase(gh<_i221.BudgetsRepository>()),
    );
    gh.lazySingleton<_i566.WatchAllBudgetUseCase>(
      () => _i566.WatchAllBudgetUseCase(gh<_i221.BudgetsRepository>()),
    );
    gh.lazySingleton<_i533.GetCategorySpendingUseCase>(
      () => _i533.GetCategorySpendingUseCase(gh<_i2.ReportRepository>()),
    );
    gh.lazySingleton<_i567.GetWeeklyTrendUseCase>(
      () => _i567.GetWeeklyTrendUseCase(gh<_i2.ReportRepository>()),
    );
    gh.lazySingleton<_i718.HomeBloc>(
      () => _i718.HomeBloc(
        watchHomeWalletsUseCase: gh<_i95.WatchHomeWalletsUseCase>(),
        watchAllBudgetUseCase: gh<_i566.WatchAllBudgetUseCase>(),
        watchHomeTransactionsUseCase: gh<_i753.WatchHomeTransactionsUseCase>(),
      ),
    );
    gh.lazySingleton<_i1029.BudgetsBloc>(
      () => _i1029.BudgetsBloc(
        insertBudgetUseCase: gh<_i252.InsertBudgetUseCase>(),
        watchAllBudgetUseCase: gh<_i566.WatchAllBudgetUseCase>(),
        getAvailableCategoriesUseCase:
            gh<_i898.GetAvailableCategoriesUseCase>(),
      ),
    );
    gh.lazySingleton<_i451.InsertWalletUseCase>(
      () => _i451.InsertWalletUseCase(
        welletsRepository: gh<_i820.WelletsRepository>(),
      ),
    );
    gh.lazySingleton<_i359.WatchWalletsUseCase>(
      () => _i359.WatchWalletsUseCase(
        welletsRepository: gh<_i820.WelletsRepository>(),
      ),
    );
    gh.lazySingleton<_i554.AccountsBloc>(
      () => _i554.AccountsBloc(
        insertWalletUseCase: gh<_i451.InsertWalletUseCase>(),
        watchWalletsUseCase: gh<_i359.WatchWalletsUseCase>(),
      ),
    );
    gh.lazySingleton<_i794.ReportBloc>(
      () => _i794.ReportBloc(
        gh<_i533.GetCategorySpendingUseCase>(),
        gh<_i567.GetWeeklyTrendUseCase>(),
      ),
    );
    return this;
  }
}

class _$DatabaseModule extends _i449.DatabaseModule {}
