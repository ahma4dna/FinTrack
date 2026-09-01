import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';
import 'package:fintrack/features/accounts/domain/use_case/insert_wallet_use_case.dart';
import 'package:fintrack/features/accounts/domain/use_case/watch_wallets_use_case.dart';
import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_bloc.dart';
import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_event.dart';
import 'package:fintrack/features/accounts/presentaion/state_manege/bloc/accounts_state.dart';

import 'accounts_bloc_test.mocks.dart';

@GenerateMocks([
  InsertWalletUseCase,
  WatchWalletsUseCase,
])
void main() {
  late MockInsertWalletUseCase insertWalletUseCase;
  late MockWatchWalletsUseCase watchWalletsUseCase;
  late AccountsBloc bloc;

  final wallet = WalletModel(
    id: 1,
    name: 'Cash',
    type: 'cash',
    balance: 500.0,
    iconName: 'wallet',
    sortOrder: 0,
    isArchived: false,
    createdAt: DateTime(2026, 9, 1),
    updatedAt: DateTime(2026, 9, 1),
  );

  final wallets = [wallet];

  setUp(() {
    insertWalletUseCase = MockInsertWalletUseCase();
    watchWalletsUseCase = MockWatchWalletsUseCase();

    bloc = AccountsBloc(
      insertWalletUseCase: insertWalletUseCase,
      watchWalletsUseCase: watchWalletsUseCase,
    );
  });

  tearDown(() async {
    await bloc.close();
  });

  // UpdateWalletsEvent

  blocTest<AccountsBloc, AccountsState>(
    'emits updated wallets when UpdateWalletsEvent is added',
    build: () => bloc,
    act: (bloc) {
      bloc.add(
        UpdateWalletsEvent(
          walletsModel: wallets,
        ),
      );
    },
    expect: () => [
      AccountsState(
        wallestModel: wallets,
      ),
    ],
  );

  // InertWalletEvent

  blocTest<AccountsBloc, AccountsState>(
    'calls InsertWalletUseCase when InertWalletEvent is added',
    build: () {
      when(
        insertWalletUseCase.insertWallet(wallet),
      ).thenAnswer(
        (_) async => 1,
      );

      return bloc;
    },
    act: (bloc) {
      bloc.add(
        InertWalletEvent(
          walletModel: wallet,
        ),
      );
    },
    expect: () => [],
    verify: (_) {
      verify(
        insertWalletUseCase.insertWallet(wallet),
      ).called(1);
    },
  );

  // WatchWalletsEvent

  blocTest<AccountsBloc, AccountsState>(
    'emits wallets when WatchWalletsEvent is added',
    build: () {
      when(
        watchWalletsUseCase.watchWallet(),
      ).thenAnswer(
        (_) => Stream.value(wallets),
      );

      return bloc;
    },
    act: (bloc) {
      bloc.add(
        WatchWalletsEvent(),
      );
    },
    expect: () => [
      AccountsState(
        wallestModel: wallets,
      ),
    ],
    verify: (_) {
      verify(
        watchWalletsUseCase.watchWallet(),
      ).called(1);
    },
  );
}
