import 'package:equatable/equatable.dart';
import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';

sealed class AccountsEvent extends Equatable {
  const AccountsEvent();
}

final class InertWalletEvent extends AccountsEvent {
  final WalletModel walletModel;

  const InertWalletEvent({required this.walletModel});
  @override
  List<Object?> get props => [walletModel];
}

final class WatchWalletsEvent extends AccountsEvent {
  @override
  List<Object?> get props => [];
}

final class UpdateWalletsEvent extends AccountsEvent {
  final List<WalletModel> walletsModel;

  const UpdateWalletsEvent({required this.walletsModel});
  @override
  List<Object> get props => [walletsModel];
}
