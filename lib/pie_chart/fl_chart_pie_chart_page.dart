import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:gap/gap.dart';

class FlChartPieChartPage extends StatelessWidget {
  const FlChartPieChartPage({Key? key}) : super(key: key);

  static const routeName = '/pie_chart/fl_chart';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final sections = [
      PieChartSectionData(
        title: 'タイトル1',
        showTitle: false,
        badgeWidget: const _BadgeWidget(label: '50%'),
        color: colorScheme.primary,
        value: 50,
      ),
      PieChartSectionData(
        title: 'タイトル2',
        showTitle: false,
        badgeWidget: const _BadgeWidget(label: '40%'),
        color: colorScheme.primaryVariant,
        value: 40,
      ),
      PieChartSectionData(
        title: 'タイトル3',
        showTitle: false,
        badgeWidget: const _BadgeWidget(label: '10%'),
        color: Colors.orange,
        value: 10,
      ),
    ];

    return Scaffold(
      backgroundColor: colorScheme.primaryVariant,
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: colorScheme.surface,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: 360,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        sections: sections,
                        startDegreeOffset: -90,
                        pieTouchData: PieTouchData(
                          touchCallback: (touchEvent, touchResponse) {
                            // タップイベントが発生しているか否かを間引く用のプロパティと推測
                            if (touchEvent.isInterestedForInteractions) {
                              return;
                            }

                            // これがnullになるのはどういった場合？
                            if (touchResponse == null) {
                              return;
                            }
                            // 中央の部分もclickableになっていて、
                            // その場合のtouchSectionIndexは`-1`となるのを確認
                            logger.info(
                              'touchedSectionIndex: '
                              '${touchResponse.touchedSection!.touchedSectionIndex},'
                              'touchedSection: ${touchResponse.touchedSection!.touchedSection},',
                            );
                          },
                        ),
                      ),
                      swapAnimationDuration: const Duration(seconds: 1),
                      swapAnimationCurve: Curves.easeInOut,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: sections
                        .map((s) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: _Legend(color: s.color, label: s.title),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({
    Key? key,
    required this.color,
    required this.label,
  }) : super(key: key);

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: color,
          size: 12,
        ),
        const Gap(2),
        Text(
          label,
          style: theme.textTheme.caption!.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyText1!.color,
          ),
        ),
      ],
    );
  }
}

class _BadgeWidget extends StatelessWidget {
  const _BadgeWidget({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Text(
      label,
      style: theme.textTheme.caption!.copyWith(
        color: colorScheme.surface,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
