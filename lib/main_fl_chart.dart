import 'package:dartx/dartx.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

void main() => runApp(
      const ProviderScope(child: App()),
    );

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

// ある年の月ごとのサンプルデータ
const _json = [
  {'month': 1, 'value': 3751},
  {'month': 2, 'value': 4382},
  {'month': 3, 'value': 4292},
  {'month': 4, 'value': 4995},
  {'month': 5, 'value': 4779},
  {'month': 6, 'value': 4923},
  {'month': 7, 'value': 4801},
  {'month': 8, 'value': 4367},
  {'month': 9, 'value': 3869},
  {'month': 10, 'value': 4998},
  {'month': 11, 'value': 4356},
  {'month': 12, 'value': 4038},
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final titleTextStyle = theme.textTheme.titleMedium!;
    final avg = _json.averageBy((e) => e['value']!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fl Chart Example'),
      ),
      body: SizedBox(
        height: 280,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: LineChart(
            LineChartData(
              // 特定のx/y軸にハイライトをつけることができる
              // rangeAnnotations: RangeAnnotations(
              //   verticalRangeAnnotations: [
              //     VerticalRangeAnnotation(x1: 3, x2: 4, color: Colors.yellow),
              //   ],
              // ),

              // 基準線を描画できる
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: avg,
                    color: Colors.grey,
                    strokeWidth: 1,
                    dashArray: [4],
                    label: HorizontalLineLabel(
                      show: true,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                      labelResolver: (line) =>
                          'AVG: ${NumberFormat('#,###').format(avg)}',
                    ),
                  ),
                ],
              ),
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  axisNameWidget: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Fl Chart Example',
                      style: titleTextStyle,
                    ),
                  ),
                  // axisNameWidgetと同じ大サイズにすると埋もれてしまい不自然なので
                  // 2倍程度のサイズを指定するとちょうどよい
                  axisNameSize: titleTextStyle.fontSize! * 2,
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) => SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(
                        '${value.toInt() + 1}月',
                        style: theme.textTheme.labelMedium,
                      ),
                    ),
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(reservedSize: 40),
                ),
              ),
              minY: 3500,
              maxY: 5500,
              backgroundColor: colorScheme.primaryContainer.withOpacity(.5),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(
                border: const Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (group) => const Color(0xFFE0E2E4),
                  getTooltipItems: (touchedSpots) => [
                    for (final spot in touchedSpots)
                      LineTooltipItem(
                        '''${spot.x.toInt() + 1}月: ${NumberFormat('#,###').format(spot.y)}''',
                        theme.textTheme.bodyMedium!.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                  ],
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  color: colorScheme.primary,
                  spots: [
                    for (final data in _json)
                      FlSpot(
                        (data['month']! - 1).toDouble(),
                        data['value']!.toDouble(),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
