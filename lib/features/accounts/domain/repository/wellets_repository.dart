import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';

abstract class WelletsRepository {
  Future<int> insertWallet(WalletModel wallet);
}
