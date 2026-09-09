import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:flutter/material.dart';

class TitleFeaildWidget extends StatelessWidget {
  const new({
    super.key,
    required this.title,
    required this.appContext,
  });

  final TextEditingController title;
  final AppContext appContext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: title,
      decoration: InputDecoration(
        hint: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p10,
            vertical: AppPadding.p5,
          ),
          child: Text(
            appContext.localText.ex_coffe,
            style: AppStyles.getRegularSens14(
              context: context,
              fontSize: AppSize.s18,
              color: const Color(0xFF64707A),
            ),
          ),
        ),
      ),
    );
  }
}
