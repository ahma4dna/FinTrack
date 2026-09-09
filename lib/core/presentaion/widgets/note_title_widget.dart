import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart' show AppContext;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NoteTitleWidget extends StatelessWidget {
  const new({
    super.key,
    required this.appContext,
  });

  final AppContext appContext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          appContext.localText.notes,
          style: AppStyles.getMeduimSens12(
            context: context,
            fontSize: AppSize.s16,
            color: Color(0xFF64707A),
          ),
        ),
        Text(
          "(${appContext.localText.optinal})",
          style: AppStyles.getRegularSens10(
            context: context,
            fontSize: AppSize.s16,
            color: Color(0xFF64707A),
          ),
        ),
        const Gap(AppSize.s5),
      ],
    );
  }
}
