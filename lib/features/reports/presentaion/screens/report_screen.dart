import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_padding.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/core/utils/constant.dart';
import 'package:fintrack/di/injection.dart';
import 'package:fintrack/features/reports/presentaion/state_manege/bloc/report_bloc.dart';
import 'package:fintrack/features/reports/presentaion/state_manege/bloc/report_event.dart';
import 'package:fintrack/features/reports/presentaion/state_manege/bloc/report_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ReportScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final appContext = AppContext.of(context);
    return BlocProvider.value(
      value: getIt<ReportBloc>()
        ..add(GetCategorySpendingEvent())
        ..add(GetWeeklyTrendEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            appContext.localText.report,
            style: AppStyles.getSemiBoldSens20(
              context: context,
              fontSize: AppSize.s24,
            ),
          ),
        ),
        body: BlocBuilder<ReportBloc, ReportState>(
          builder: (context, state) {
            if (state.categorySpending.isEmpty) {
              return Center(
                child: Text(
                  "لاتوجد تقارير",
                  style: AppStyles.getSemiBoldSens20(
                    context: context,
                    fontSize: AppSize.s20,
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20,
                      vertical: AppPadding.p16,
                    ),
                    child: IncoveByCategoryWidget(
                      appContext: appContext,
                      state: state,
                    ),
                  ),
                  IncoveWeklyLineChartWidget(
                    appContext: appContext,
                    state: state,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class IncoveWeklyLineChartWidget extends StatelessWidget {
  const IncoveWeklyLineChartWidget({
    super.key,
    required this.appContext,
    required this.state,
  });

  final AppContext appContext;
  final ReportState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p20),
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s16),
          side: BorderSide(
            width: 1,
            color: AppColors.border,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(AppSize.s8),
          Text(
            appContext.localText.incove_wekaly,
            style: AppStyles.getMeduimSens14(
              context: context,
              color: const Color(0xFF121820),
              fontSize: AppSize.s22,
            ),
          ),
          const Gap(AppSize.s30),
          SizedBox(
            height: AppSize.s220,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < state.weeklyTrend.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              state.weeklyTrend[index].label,
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF64707A), // slate
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),

                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => Color(0xFF121820),
                    getTooltipItems: (spots) {
                      return spots.map((spot) {
                        return LineTooltipItem(
                          '\$${spot.y.toInt()}',
                          TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                        );
                      }).toList();
                    },
                  ),
                ),

                minY: 0,

                lineBarsData: [
                  LineChartBarData(
                    spots: state.weeklyTrend
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble(), e.value.amount))
                        .toList(),
                    isCurved: true,
                    curveSmoothness: 0.3,
                    color: Color(0xFF0D5C56),
                    barWidth: 2.5,
                    dotData: FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IncoveByCategoryWidget extends StatelessWidget {
  final AppContext appContext;
  final ReportState state;
  const IncoveByCategoryWidget({
    super.key,
    required this.appContext,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p20),
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s16),
          side: BorderSide(
            width: 1,
            color: AppColors.border,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(AppSize.s8),
          Text(
            appContext.localText.incove_by_category,
            style: AppStyles.getMeduimSens14(
              context: context,
              color: const Color(0xFF121820),
              fontSize: AppSize.s22,
            ),
          ),
          const Gap(AppSize.s30),
          SizedBox(
            height: AppSize.s220,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: AppSize.s65,
                sectionsSpace: AppSize.s5,
                sections: state.categorySpending
                    .map((data) {
                      return PieChartSectionData(
                        value: data.amount,
                        color: Color(int.parse(data.colorHex)),
                        radius: AppSize.s30,
                        showTitle: false,
                      );
                    })
                    .toList()
                    .cast<PieChartSectionData>(),
              ),
            ),
          ),
          const Gap(AppSize.s24),
          Column(
            children: state.categorySpending
                .map(
                  (data) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppPadding.p8,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: AppSize.s15,
                            height: AppSize.s15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(int.parse(data.colorHex)),
                            ),
                          ),
                          const Gap(AppSize.s8),
                          Text(
                            data.name,
                            textAlign: TextAlign.right,
                            style: AppStyles.getRegularSens10(
                              context: context,
                              fontSize: AppSize.s16,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '\$${formatNumber(data.amount)}',
                            textAlign: TextAlign.right,
                            style: AppStyles.getRegularMono12(
                              context: context,
                              color: const Color(0xFF64707A),
                              fontSize: AppSize.s16,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
                .toList()
                .cast<Widget>(),
          ),
        ],
      ),
    );
  }
}
