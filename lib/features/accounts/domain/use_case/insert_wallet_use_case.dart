import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';
import 'package:fintrack/features/accounts/domain/repository/wellets_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InsertWalletUseCase {
  final WelletsRepository welletsRepository;

  InsertWalletUseCase({required this.welletsRepository});

  Future<int> insertWallet(WalletModel wallet) async {
    return await welletsRepository.insertWallet(wallet);
  }
}
