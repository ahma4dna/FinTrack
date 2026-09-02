import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SaveAccountButtonWidget extends StatelessWidget {
  const new({
    super.key,
    required this.appContext,
  });

  final AppContext appContext;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(
          AppPadding.p16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s16),
        ),
      ),
      onPressed: () {},
      child: Text(
        appContext.localText.save_account,
        style: AppStyles.getSemiBoldSens16(
          context: context,
          fontSize: AppSize.s18,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class FirstBalanceFieldWidget extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 1,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(7),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        hint: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16,
            vertical: AppPadding.p10,
          ),
          child: Text(
            "\$0.00",
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
