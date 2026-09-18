import 'package:equatable/equatable.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object?> get props => [];
}

class GetCategorySpendingEvent extends ReportEvent {
  const GetCategorySpendingEvent();
}

class GetWeeklyTrendEvent extends ReportEvent {
  const GetWeeklyTrendEvent();
}
