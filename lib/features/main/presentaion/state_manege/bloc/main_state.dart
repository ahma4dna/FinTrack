import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  final int currntIndex;
  const MainState({this.currntIndex = 0});
  MainState copyWith({int? currntIndex}) => MainState(
    currntIndex: currntIndex ?? this.currntIndex,
  );
  @override
  List<Object> get props => [currntIndex];
}
