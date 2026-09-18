import 'package:fintrack/features/home/domain/models/wallets_with_total.dart';
import 'package:fintrack/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchHomeWalletsUseCase {
  final HomeRepository repository;
  WatchHomeWalletsUseCase(this.repository);

  Stream<WalletsWithTotal> call() => repository.watchWalletsWithTotal();
}
