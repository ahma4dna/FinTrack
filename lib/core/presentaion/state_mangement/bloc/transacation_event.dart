import 'package:equatable/equatable.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/domain/models/transaction_with_details.dart';

sealed class TransacationEvent extends Equatable {
  const TransacationEvent();
}

final class AddTranactionEvnt extends TransacationEvent {
  final TransactionsTableCompanion txn;

  const AddTranactionEvnt({required this.txn});
  @override
  List<Object?> get props => [txn];
}

final class DeleteTranactionEvnt extends TransacationEvent {
  final int transactionId;

  const DeleteTranactionEvnt({required this.transactionId});
  @override
  List<Object?> get props => [transactionId];
}

final class WatchByWalletTranactionEvnt extends TransacationEvent {
  final int walletId;

  const WatchByWalletTranactionEvnt({required this.walletId});
  @override
  List<Object?> get props => [walletId];
}

final class UpdateWalletTranactionEvnt extends TransacationEvent {
  final List<TransactionWithDetails> transactionWithDetails;

  const UpdateWalletTranactionEvnt({required this.transactionWithDetails});
  @override
  List<Object?> get props => [transactionWithDetails];
}

final class GetCategoryEvent extends TransacationEvent {
  const GetCategoryEvent();
  @override
  List<Object?> get props => [];
}
