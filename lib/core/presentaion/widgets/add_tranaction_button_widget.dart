import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:flutter/material.dart';

class AddTranactionButtonWidget extends StatelessWidget {
  const AddTranactionButtonWidget({
    super.key,
    required this.appContext,
    required this.onPressed,
  });

  final AppContext appContext;
  final void Function() onPressed;

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
      onPressed: onPressed,
      child: Text(
        appContext.localText.save_transaction,
        style: AppStyles.getSemiBoldSens16(
          context: context,
          fontSize: AppSize.s18,
          color: AppColors.white,
        ),
      ),
    );
  }
}
