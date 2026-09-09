import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/domain/repository/transactions_repository.dart';
import 'package:fintrack/core/domain/use_case/insert_transaction_use_case.dart';

import 'insert_transaction_use_case_test.mocks.dart';

@GenerateMocks([TransactionsRepository])
void main() {
  late MockTransactionsRepository repository;
  late InsertTransactionUseCase useCase;

  setUp(() {
    repository = MockTransactionsRepository();

    useCase = InsertTransactionUseCase(repository);
  });

  test('should insert transaction and return transaction id', () async {
    // Arrange

    final transaction = TransactionsTableCompanion.insert(
      walletId: 1,
      categoryId: 5,
      type: 'expense',
      amount: 200,
      title: 'Lunch',
      date: DateTime(2026, 9, 5),
    );

    when(repository.insertTransaction(transaction)).thenAnswer((_) async => 10);

    // Act

    final result = await useCase.insertTransaction(transaction);

    // Assert

    expect(result, 10);

    verify(
      repository.insertTransaction(transaction),
    ).called(1);
  });
}
