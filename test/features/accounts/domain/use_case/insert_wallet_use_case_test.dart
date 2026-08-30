import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';
import 'package:fintrack/features/accounts/domain/repository/wellets_repository.dart';
import 'package:fintrack/features/accounts/domain/use_case/insert_wallet_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'insert_wallet_use_case_test.mocks.dart';

@GenerateMocks([WelletsRepository])
void main() async {
  late MockWelletsRepository mockWelletsRepository;
  late InsertWalletUseCase insertWalletUseCase;
  setUp(
    () {
      mockWelletsRepository = MockWelletsRepository();
      insertWalletUseCase = InsertWalletUseCase(
        welletsRepository: mockWelletsRepository,
      );
    },
  );
  test(
    "should insert wallet and return generated id",
    () async {
      // Arrange
      final wallet = WalletModel(
        name: 'bank',
        balance: 500,
      );

      when(mockWelletsRepository.insertWallet(wallet)).thenAnswer(
        (_) async => 1,
      );
      final result = await insertWalletUseCase.insertWallet(wallet);
      expect(result, 1);
      verify(mockWelletsRepository.insertWallet(wallet)).called(1);
    },
  );
}
