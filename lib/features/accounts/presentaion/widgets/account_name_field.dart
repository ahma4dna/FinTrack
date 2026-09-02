import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountNameField extends StatelessWidget {
  final TextEditingController name;
  const AccountNameField({
    super.key,
    required this.appContext,
    required this.name,
  });

  final AppContext appContext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: name,
      minLines: 1,
      maxLines: 1,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return appContext.localText.this_fiald_requaird;
        }
        return null;
      },
      keyboardType: TextInputType.name,
      inputFormatters: [
        LengthLimitingTextInputFormatter(15),
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z\u0600-\u06FF\s]'),
        ),
      ],
      decoration: InputDecoration(
        hint: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16,
            vertical: AppPadding.p10,
          ),
          child: Text(
            appContext.localText.ex_wallet_day,
            style: AppStyles.getRegularSens14(
              context: context,
              fontSize: AppSize.s16,
              color: Color(0xFF64707A),
            ),
          ),
        ),
      ),
    );
  }
}
