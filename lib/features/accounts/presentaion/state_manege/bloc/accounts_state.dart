import 'package:equatable/equatable.dart';
import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';

class AccountsState extends Equatable {
  final List<WalletModel> wallestModel;
  const AccountsState({
    this.wallestModel = const [],
  });
  AccountsState copyWith({List<WalletModel>? wallestModel}) => AccountsState(
    wallestModel: wallestModel ?? this.wallestModel,
  );
  @override
  List<Object> get props => [wallestModel];
}
