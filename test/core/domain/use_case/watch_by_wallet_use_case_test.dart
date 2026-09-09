import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:fintrack/core/domain/models/transaction_with_details.dart';
import 'package:fintrack/core/domain/repository/transactions_repository.dart';
import 'package:fintrack/core/domain/use_case/watch_by_wallet_use_case.dart';

import 'watch_by_wallet_use_case_test.mocks.dart';

@GenerateMocks([TransactionsRepository])
void main() {
  late MockTransactionsRepository repository;
  late WatchByWalletUseCase useCase;

  setUp(() {
    repository = MockTransactionsRepository();

    useCase = WatchByWalletUseCase(repository);
  });

  test('should watch transactions by wallet', () async {
    // Arrange

    final transactions = <TransactionWithDetails>[];

    when(repository.watchByWallet(1)).thenAnswer((_) => Stream.value(transactions));

    // Act

    final result = await useCase.watchByWallet(1).first;

    // Assert

    expect(result, transactions);

    verify(
      repository.watchByWallet(1),
    ).called(1);
  });
}
