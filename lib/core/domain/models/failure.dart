import '../../data/error_handling/data_source.dart';

class Failure implements Exception {
  final int code;
  final DataSource localMessage;

  Failure({required this.code, required this.localMessage});
}
