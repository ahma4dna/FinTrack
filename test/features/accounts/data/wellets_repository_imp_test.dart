import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:fintrack/core/database/app_database.dart';
import 'package:fintrack/features/accounts/data/dao/wallet_dao.dart';
import 'package:fintrack/features/accounts/data/repository/wellets_repository_imp.dart';
import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';

import 'wellets_repository_imp_test.mocks.dart';

@GenerateMocks([WalletDao])
void main() {
  late MockWalletDao walletDao;
  late WelletsRepositoryImp repository;

  setUp(() {
    walletDao = MockWalletDao();
    repository = WelletsRepositoryImp(
      walletDao: walletDao,
    );
  });
  //1
  test(
    'should convert WalletModel to WalletsTableCompanion',
    () async {
      // Arrange

      final createdAt = DateTime(2026, 8, 30);
      final updatedAt = DateTime(2026, 8, 30);

      final wallet = WalletModel(
        id: 1,
        name: 'Cash',
        balance: 500,
        type: 'cash',
        iconName: 'wallet',
        sortOrder: 1,
        isArchived: false,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      when(
        walletDao.insertWallet(any),
      ).thenAnswer((_) async => 1);

      // Act

      final result = await repository.insertWallet(wallet);

      // Assert

      expect(result, 1);

      final companion =
          verify(
                walletDao.insertWallet(captureAny),
              ).captured.single
              as WalletsTableCompanion;

      expect(companion.name.value, wallet.name);
      expect(companion.balance.value, wallet.balance);
      expect(companion.type.value, wallet.type);
      expect(companion.iconName.value, wallet.iconName);
      expect(companion.sortOrder.value, wallet.sortOrder);
      expect(companion.isArchived.value, wallet.isArchived);
      expect(companion.createdAt.value, wallet.createdAt);
      expect(companion.updatedAt.value, wallet.updatedAt);
    },
  );

  //2
  test(
    " 'should return wallets as WalletModel stream',",
    () async {
      final wallet = WalletsTableData(
        id: 1,
        name: 'Cash',
        balance: 500,
        type: 'cash',
        iconName: 'wallet',
        sortOrder: 1,
        isArchived: false,
        createdAt: DateTime(2026, 8, 30),
        updatedAt: DateTime(2026, 8, 30),
      );

      when(walletDao.watchWallet()).thenAnswer((_) => Stream.value([wallet]));
      final result = await repository.watchWallet().first;

      expect(result.length, 1);
      expect(result.first.id, wallet.id);
      expect(result.first.name, wallet.name);
      expect(result.first.balance, wallet.balance);
      expect(result.first.type, wallet.type);
      expect(result.first.iconName, wallet.iconName);
      expect(result.first.sortOrder, wallet.sortOrder);
      expect(result.first.isArchived, wallet.isArchived);

      verify(walletDao.watchWallet()).called(1);
    },
  );
}
