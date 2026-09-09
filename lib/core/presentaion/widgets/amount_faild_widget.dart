import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountFaildWidget extends StatelessWidget {
  const new({
    super.key,
    required this.amount,
  });

  final TextEditingController amount;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      controller: amount,
      inputFormatters: [
        LengthLimitingTextInputFormatter(5),
        FilteringTextInputFormatter.digitsOnly,
      ],
      style: AppStyles.getSemiBoldMono36(context: context),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "\$0.00",
        hintStyle: AppStyles.getSemiBoldMono36(context: context),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
