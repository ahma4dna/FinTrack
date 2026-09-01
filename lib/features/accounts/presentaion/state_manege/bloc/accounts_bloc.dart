import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_event.dart';
import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc() : super(AccountsState()) {
    on<AccountsEvent>((event, emit) {});
  }
}
