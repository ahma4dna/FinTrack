import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:fintrack/core/domain/repository/transactions_repository.dart';
import 'package:fintrack/core/domain/use_case/delete_transaction_use_case.dart';

import 'delete_transaction_use_case_test.mocks.dart';

@GenerateMocks([TransactionsRepository])
void main() {
  late MockTransactionsRepository repository;
  late DeleteTransactionUseCase useCase;

  setUp(() {
    repository = MockTransactionsRepository();

    useCase = DeleteTransactionUseCase(repository);
  });

  test('should delete transaction', () async {
    // Arrange

    when(repository.deleteTransaction(10)).thenAnswer((_) async {});

    // Act

    await useCase.deleteTransaction(10);

    // Assert

    verify(
      repository.deleteTransaction(10),
    ).called(1);
  });
}
