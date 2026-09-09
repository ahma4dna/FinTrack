import 'package:bloc_test/bloc_test.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/core/domain/models/transaction_with_details.dart';
import 'package:fintrack/core/domain/use_case/delete_transaction_use_case.dart';
import 'package:fintrack/core/domain/use_case/get_category_use_case.dart';
import 'package:fintrack/core/domain/use_case/insert_transaction_use_case.dart';
import 'package:fintrack/core/domain/use_case/watch_by_wallet_use_case.dart';
import 'package:fintrack/core/presentaion/state_mangement/bloc/transacation_bloc.dart';
import 'package:fintrack/core/presentaion/state_mangement/bloc/transacation_event.dart';
import 'package:fintrack/core/presentaion/state_mangement/bloc/transacation_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'transacation_bloc_test.mocks.dart';

@GenerateMocks([
  InsertTransactionUseCase,
  DeleteTransactionUseCase,
  WatchByWalletUseCase,
  GetCategoryUseCase,
])
void main() {
  late MockInsertTransactionUseCase insertTransactionUseCase;
  late MockDeleteTransactionUseCase deleteTransactionUseCase;
  late MockWatchByWalletUseCase watchByWalletUseCase;
  late MockGetCategoryUseCase getCategoryUseCase;

  late TransacationBloc bloc;

  setUp(() {
    insertTransactionUseCase = MockInsertTransactionUseCase();
    deleteTransactionUseCase = MockDeleteTransactionUseCase();
    watchByWalletUseCase = MockWatchByWalletUseCase();
    getCategoryUseCase = MockGetCategoryUseCase();

    bloc = TransacationBloc(
      insertTransactionUseCase: insertTransactionUseCase,
      deleteTransactionUseCase: deleteTransactionUseCase,
      watchByWalletUseCase: watchByWalletUseCase,
      getCategoryUseCase: getCategoryUseCase,
    );
  });

  tearDown(() async {
    await bloc.close();
  });

  group('AddTranactionEvnt', () {
    test('should call InsertTransactionUseCase with transaction', () async {
      final txn = TransactionsTableCompanion.insert(
        walletId: 1,
        categoryId: 2,
        type: 'expense',
        amount: 100,
        title: 'Lunch',
        date: DateTime(2026, 9, 5),
      );

      when(
        insertTransactionUseCase.insertTransaction(txn),
      ).thenAnswer((_) async => 10);

      bloc.add(
        AddTranactionEvnt(txn: txn),
      );

      await Future<void>.delayed(Duration.zero);

      verify(
        insertTransactionUseCase.insertTransaction(txn),
      ).called(1);
    });
  });

  group('DeleteTranactionEvnt', () {
    test('should call DeleteTransactionUseCase with transaction id', () async {
      when(
        deleteTransactionUseCase.deleteTransaction(10),
      ).thenAnswer((_) async {});

      bloc.add(
        DeleteTranactionEvnt(
          transactionId: 10,
        ),
      );

      await Future<void>.delayed(Duration.zero);

      verify(
        deleteTransactionUseCase.deleteTransaction(10),
      ).called(1);
    });
  });

  group('WatchByWalletTranactionEvnt', () {
    blocTest<TransacationBloc, TransacationState>(
      'should watch transactions by wallet',
      build: () {
        when(
          watchByWalletUseCase.watchByWallet(1),
        ).thenAnswer(
          (_) => Stream.value(
            <TransactionWithDetails>[],
          ),
        );

        return bloc;
      },
      act: (bloc) {
        bloc.add(
          WatchByWalletTranactionEvnt(
            walletId: 1,
          ),
        );
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        isA<TransacationState>(),
      ],
      verify: (_) {
        verify(
          watchByWalletUseCase.watchByWallet(1),
        ).called(1);
      },
    );
  });

  group('UpdateWalletTranactionEvnt', () {
    blocTest<TransacationBloc, TransacationState>(
      'should update transactionWithDetails in state',
      build: () => bloc,
      act: (bloc) {
        final transactions = <TransactionWithDetails>[];

        bloc.add(
          UpdateWalletTranactionEvnt(
            transactionWithDetails: transactions,
          ),
        );
      },
      expect: () => [
        isA<TransacationState>(),
      ],
    );
  });

  blocTest(
    "get category",
    build: () {
      when(
        getCategoryUseCase.getCategory(),
      ).thenAnswer(
        (_) => Future.value(
          <CategoriesTableData>[],
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(GetCategoryEvent()),
    expect: () => [
      isA<TransacationState>(),
    ],
    verify: (bloc) {
      verify(getCategoryUseCase.getCategory()).called(1);
    },
  );
}
