import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:flutter/material.dart';

class TitleWidgetRight extends StatelessWidget {
  const TitleWidgetRight({
    super.key,
    required this.appContext,
    required this.text,
  });

  final AppContext appContext;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Text(
        text,
        style: AppStyles.getMeduimSens12(
          context: context,
          fontSize: AppSize.s16,
          color: Color(0xFF64707A),
        ),
      ),
    );
  }
}
