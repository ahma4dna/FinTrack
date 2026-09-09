import 'dart:async';

import 'package:fintrack/core/domain/use_case/delete_transaction_use_case.dart';
import 'package:fintrack/core/domain/use_case/get_category_use_case.dart';
import 'package:fintrack/core/domain/use_case/insert_transaction_use_case.dart';
import 'package:fintrack/core/domain/use_case/watch_by_wallet_use_case.dart';
import 'package:fintrack/core/presentaion/state_mangement/bloc/transacation_event.dart';
import 'package:fintrack/core/presentaion/state_mangement/bloc/transacation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TransacationBloc extends Bloc<TransacationEvent, TransacationState> {
  final InsertTransactionUseCase insertTransactionUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;
  final WatchByWalletUseCase watchByWalletUseCase;
  final GetCategoryUseCase getCategoryUseCase;
  StreamSubscription? _streamSubscription;
  TransacationBloc({
    required this.insertTransactionUseCase,
    required this.deleteTransactionUseCase,
    required this.watchByWalletUseCase,
    required this.getCategoryUseCase,
  }) : super(TransacationState()) {
    on<GetCategoryEvent>(_getCategory);
    on<AddTranactionEvnt>(_addTranaction);
    on<DeleteTranactionEvnt>(_deleteTranaction);
    on<WatchByWalletTranactionEvnt>(_watchTranaction);
    on<UpdateWalletTranactionEvnt>(_updataTranactions);
  }
  Future<void> _getCategory(GetCategoryEvent event, Emitter<TransacationState> emit) async {
    final cat = await getCategoryUseCase.getCategory();
    emit(state.copyWithe(categoriesTableData: cat));
  }

  Future<void> _addTranaction(AddTranactionEvnt event, Emitter<TransacationState> emit) async {
    await insertTransactionUseCase.insertTransaction(event.txn);
  }

  Future<void> _deleteTranaction(DeleteTranactionEvnt event, Emitter<TransacationState> emit) async {
    await deleteTransactionUseCase.deleteTransaction(event.transactionId);
  }

  Future<void> _watchTranaction(WatchByWalletTranactionEvnt event, Emitter<TransacationState> emit) async {
    await _streamSubscription?.cancel();
    _streamSubscription = watchByWalletUseCase.watchByWallet(event.walletId).listen(
      (transactionWithDetails) {
        add(
          UpdateWalletTranactionEvnt(transactionWithDetails: transactionWithDetails),
        );
      },
    );
  }

  Future<void> _updataTranactions(UpdateWalletTranactionEvnt event, Emitter<TransacationState> emit) async {
    emit(state.copyWithe(transactionWithDetails: event.transactionWithDetails));
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
