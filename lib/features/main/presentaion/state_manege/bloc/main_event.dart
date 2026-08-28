import 'package:equatable/equatable.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

final class ChangeTabEvent extends MainEvent {
  final int selctIndex;

  const ChangeTabEvent({required this.selctIndex});
  @override
  List<Object> get props => [selctIndex];
}
