import 'package:fintrack/core/utils/app_context.dart';
import 'package:flutter/widgets.dart';

extension IconeNameMapper on String {
  String toIconName(BuildContext context) {
    final appContext = AppContext.of(context);
    switch (this) {
      case "بنكي":
        return "bank";
      case 'نقدي':
        return "cash";
      case 'ائتمان':
        return "card";
      default:
        return " bank";
    }
  }
}
