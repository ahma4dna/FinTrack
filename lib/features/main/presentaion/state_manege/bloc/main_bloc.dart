import 'package:fintrack/features/main/presentaion/state_manege/bloc/main_event.dart';
import 'package:fintrack/features/main/presentaion/state_manege/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<ChangeTabEvent>(_chnageTab);
  }

  void _chnageTab(ChangeTabEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(currntIndex: event.selctIndex));
  }
}
