// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fintrack/core/database/app_database.dart' as _i449;
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
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i688.WalletDao>(
      () => _i688.WalletDao(gh<_i449.AppDatabase>()),
    );
    gh.lazySingleton<_i820.WelletsRepository>(
      () => _i94.WelletsRepositoryImp(walletDao: gh<_i688.WalletDao>()),
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
    return this;
  }
}
