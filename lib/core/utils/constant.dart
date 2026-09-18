import 'package:intl/intl.dart';

String formatNumber(num value) {
  return NumberFormat('#,###').format(value);
}
