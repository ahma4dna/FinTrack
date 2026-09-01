import 'dart:async';

import 'package:fintrack/features/accounts/domain/use_case/insert_wallet_use_case.dart';
import 'package:fintrack/features/accounts/domain/use_case/watch_wallets_use_case.dart';
import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_event.dart';
import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final InsertWalletUseCase insertWalletUseCase;
  final WatchWalletsUseCase watchWalletsUseCase;
  StreamSubscription? _streamSubscription;

  AccountsBloc({required this.insertWalletUseCase, required this.watchWalletsUseCase}) : super(AccountsState()) {
    on<UpdateWalletsEvent>(_updatWallets);
    on<WatchWalletsEvent>(_watchWallets);
    on<InertWalletEvent>(_insertWallet);
  }

  void _updatWallets(UpdateWalletsEvent event, Emitter<AccountsState> emit) {
    emit(state.copyWith(wallestModel: event.walletsModel));
  }

  void _watchWallets(WatchWalletsEvent event, Emitter<AccountsState> emit) async {
    await _streamSubscription?.cancel();
    watchWalletsUseCase.watchWallet().listen(
      (walletsModel) {
        add(UpdateWalletsEvent(walletsModel: walletsModel));
      },
    );
  }

  Future<void> _insertWallet(InertWalletEvent event, Emitter<AccountsState> emit) async {
    await insertWalletUseCase.insertWallet(event.walletModel);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
