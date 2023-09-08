import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _expansionMessageSwitcher =
    StateNotifierProvider<_ExpansionMessageSwitcher, bool>(
  (ref) => _ExpansionMessageSwitcher(),
);

class _ExpansionMessageSwitcher extends StateNotifier<bool> {
  _ExpansionMessageSwitcher() : super(false);

  void show() {
    state = !state;
    // ここにFirebase AnalyticsやSharedPreferencesなどの追加ロジックを書くイメージ
  }
}

class ExpansionMessageByRiverpod extends ConsumerWidget {
  const ExpansionMessageByRiverpod({super.key});

  // 引用元: https://news.yahoo.co.jp/articles/ec8a44f6e1851c3b9f35edf4d74988611e25f8c7
  static const _message = '''
国会では26日から補正予算案を巡る予算委員会が行われる。夏の参院選を前にして、今国会最後の本格論戦の場となることから、与野党の攻防は激しさを増しそうだ。

国会では25日から今年度の補正予算案の審議が始まっていて、衆議院では26日、27日、参議院では週明けの30日、31日と、それぞれ2日間予算委員会が開催される。その後、予算委員会の集中審議も、衆議院では6月1日に、参議院では3日に行うことになり、6月15日の会期末を前に、今国会最後となる与野党の本格論戦が行われる。

論戦の焦点は?
予算委員会で一つの焦点となるのは「予備費」についてだ。さらなる原油価格高騰や新型コロナの感染拡大に備えた1兆5000億円の予備費について、立憲民主党は「緊急時という名前の中で、何でもありになって、国会の監視機能も果たされていない」などと批判していて、予備費の在り方を巡り、政府を追及する構えだ。

また岸田首相が唱える「新しい資本主義」について、日本維新の会は「おぼろげに聞こえてくる政策の大半は従来の焼き直しで大風呂敷を広げる意味がどこにあるのか疑問」と指摘、予算委員会の質疑で「化けの皮をはがす」と意気込む。''';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final show = ref.watch(_expansionMessageSwitcher);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.amber,
            child: Text(
              _message,
              maxLines: show ? null : 3,

              // `maxLines: null`かつ`TextOverflow.ellipsis`指定だと1行分しか表示されないので
              // overflowフィールドもnullにすると上手くいく。
              overflow: show ? null : TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(_expansionMessageSwitcher.notifier).show();
            },
            child: Text(show ? '折りたたむ' : 'もっとみる'),
          ),
        ],
      ),
    );
  }
}
