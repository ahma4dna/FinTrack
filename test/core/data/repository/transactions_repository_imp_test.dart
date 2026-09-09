import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:fintrack/core/data/dao/transactions_daos.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/data/repository/transactions_repository_imp.dart';
import 'package:fintrack/core/domain/models/transaction_with_details.dart';

import 'transactions_repository_imp_test.mocks.dart';

@GenerateMocks([TransactionsDaos])
void main() {
  late MockTransactionsDaos transactionsDaos;
  late TransactionsRepositoryImp repository;

  setUp(() {
    transactionsDaos = MockTransactionsDaos();

    repository = TransactionsRepositoryImp(
      transactionsDaos: transactionsDaos,
    );
  });

  // insertTransaction

  test('insertTransaction should call DAO and return transaction id', () async {
    // Arrange

    final transaction = TransactionsTableCompanion.insert(
      walletId: 1,
      categoryId: 5,
      type: 'expense',
      amount: 200,
      title: 'Lunch',
      date: DateTime(2026, 9, 5),
    );

    when(transactionsDaos.insertTransaction(transaction)).thenAnswer((_) async => 10);

    // Act

    final result = await repository.insertTransaction(transaction);

    // Assert

    expect(result, 10);

    verify(
      transactionsDaos.insertTransaction(transaction),
    ).called(1);
  });

  // deleteTransaction

  test('deleteTransaction should call DAO with transaction id', () async {
    // Arrange

    when(transactionsDaos.deleteTransaction(10)).thenAnswer((_) async {});

    // Act

    await repository.deleteTransaction(10);

    // Assert

    verify(
      transactionsDaos.deleteTransaction(10),
    ).called(1);
  });

  // watchByWallet

  test('watchByWallet should return stream from DAO', () async {
    // Arrange

    final transactions = <TransactionWithDetails>[];

    when(transactionsDaos.watchByWallet(1)).thenAnswer((_) => Stream.value(transactions));

    // Act

    final result = await repository.watchByWallet(1).first;

    // Assert

    expect(result, transactions);

    verify(
      transactionsDaos.watchByWallet(1),
    ).called(1);
  });
}
