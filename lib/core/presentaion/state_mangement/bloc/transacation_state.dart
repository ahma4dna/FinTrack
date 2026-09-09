import 'package:equatable/equatable.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/domain/models/transaction_with_details.dart';

final class TransacationState extends Equatable {
  final List<TransactionWithDetails> transactionWithDetails;
  final List<CategoriesTableData> categoriesTableData;
  const TransacationState({
    this.transactionWithDetails = const [],
    this.categoriesTableData = const [],
  });
  TransacationState copyWithe({
    List<TransactionWithDetails>? transactionWithDetails,
    List<CategoriesTableData>? categoriesTableData,
  }) => TransacationState(
    transactionWithDetails: transactionWithDetails ?? this.transactionWithDetails,
    categoriesTableData: categoriesTableData ?? this.categoriesTableData,
  );
  @override
  List<Object> get props => [transactionWithDetails, categoriesTableData];
}
