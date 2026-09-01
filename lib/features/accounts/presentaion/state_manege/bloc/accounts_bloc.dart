import 'dart:async';

import 'package:fintrack/features/accounts/domain/use_case/insert_wallet_use_case.dart';
import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_event.dart';
import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final InsertWalletUseCase insertWalletUseCase;
  AccountsBloc({required this.insertWalletUseCase}) : super(AccountsState()) {
    on<InertWalletEvent>(_insertWallet);
  }

  Future<void> _insertWallet(InertWalletEvent event, Emitter<AccountsState> emit) async {
    await insertWalletUseCase.insertWallet(event.walletModel);
  }
}
