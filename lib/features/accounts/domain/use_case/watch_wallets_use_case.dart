import 'package:fintrack/features/accounts/domain/models/wallet_model.dart';
import 'package:fintrack/features/accounts/domain/repository/wellets_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchWalletsUseCase {
  final WelletsRepository welletsRepository;
  WatchWalletsUseCase({required this.welletsRepository});
  Stream<List<WalletModel>> watchWallet() {
    return welletsRepository.watchWallet();
  }
}
