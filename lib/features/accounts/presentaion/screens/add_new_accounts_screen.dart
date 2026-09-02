import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/features/accounts/presentaion/widgets/account_name_field.dart';
import 'package:fintrack/features/accounts/presentaion/widgets/save_account_button_widget.dart';
import 'package:fintrack/features/accounts/presentaion/widgets/type_account_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AddNewAccountsScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<AddNewAccountsScreen> createState() => _AddNewAccountsScreenState();
}

class _AddNewAccountsScreenState extends State<AddNewAccountsScreen> {
  int slectIndex = 0;
  String slectType = "";
  @override
  Widget build(BuildContext context) {
    final AppContext appContext = AppContext.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: AppSize.s26,
          ),
        ),
        title: Text(
          appContext.localText.add_account,
          style: AppStyles.getSemiBoldSens16(context: context, fontSize: AppSize.s18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.p20,
          right: AppPadding.p20,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(AppSize.s16),
              Text(
                appContext.localText.add_account,
                style: AppStyles.getMeduimSens12(
                  context: context,
                  fontSize: AppSize.s16,
                  color: Color(0xFF64707A),
                ),
              ),
              const Gap(AppSize.s8),
              AccountNameField(appContext: appContext),
              const Gap(AppSize.s20),
              Text(
                appContext.localText.type_account,
                style: AppStyles.getMeduimSens12(
                  context: context,
                  fontSize: AppSize.s16,
                  color: Color(0xFF64707A),
                ),
              ),
              const Gap(AppSize.s8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TypeAccountWidget(
                    appContext: appContext,
                    selctIndex: slectIndex,
                    inedx: 0,
                    type: appContext.localText.cash,
                    onTap: () {
                      setState(() {
                        slectIndex = 0;
                        slectType = appContext.localText.cash;
                      });
                    },
                  ),
                  TypeAccountWidget(
                    appContext: appContext,
                    selctIndex: slectIndex,
                    inedx: 1,
                    type: appContext.localText.bank,
                    onTap: () {
                      setState(() {
                        slectIndex = 1;
                        slectType = appContext.localText.bank;
                      });
                    },
                  ),
                  TypeAccountWidget(
                    appContext: appContext,
                    selctIndex: slectIndex,
                    inedx: 2,
                    type: appContext.localText.cridit,
                    onTap: () {
                      setState(() {
                        slectIndex = 2;
                        slectType = appContext.localText.cridit;
                      });
                    },
                  ),
                ],
              ),
              const Gap(AppSize.s20),
              Text(
                appContext.localText.balance_first,
                style: AppStyles.getMeduimSens12(
                  context: context,
                  fontSize: AppSize.s16,
                  color: Color(0xFF64707A),
                ),
              ),
              const Gap(AppSize.s8),
              const FirstBalanceFieldWidget(),
              const Gap(AppSize.s32),
              SaveAccountButtonWidget(appContext: appContext),
            ],
          ),
        ),
      ),
    );
  }
}
