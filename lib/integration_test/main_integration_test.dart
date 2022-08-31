import 'package:flutter/material.dart';
import 'package:flutter_playground/main_integration.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('counter test', () {
    testWidgets('tap floating action increment button', (tester) async {
      // 指定ファイル（今回だと `'package:flutter_playground/main_integration.dart'`）のmain関数を実行する
      // runAppを呼ぶのが目的
      app.main();

      // pumpは直訳するとポンプでその振る舞いの通り凹む→一定時間待機するような挙動になる
      // pumpメソッドでDurationを明示すると一定時間待機できる。
      // ex. 3秒待機の例
      // await tester.pump(const Duration(seconds: 3));

      // `pumpAndSettle`は描画フレームが無くなるまでpumpしてくれるメソッド。
      // I/Oが絡んだり非同期でデータ取得→Widget描画などの処理が絡む場合は必要になってくる。
      //
      // runApp直後に画面が起動するのを待つのに必須なのでこの位置に必要
      await tester.pumpAndSettle();

      // `findsOneWidget`はその画面の中で特定のText系 Widgetの合致する表示のマッチを確認できる
      // This will match [Text], [Text.rich], and [EditableText] widgets that
      //
      // `find`は、finder.dartクラスに定義されているCommonFindersクラスで特定のWidgetを探してくれる
      // Text, Image, Keyなど用意されている
      expect(find.text('count: 0'), findsOneWidget);

      expect(find.byKey(const Key('countLabel')), findsOneWidget);

      // [追記] これは通らない
      // 上記のfind.textとfind.byWidgetのTextWidget指定は同義ということになる。
      // expect(find.byWidget(const Scaffold()), findsOneWidget);

      // WidgetTesterに操作を要求するWidgetを指定する
      // 指定方法はツールチップがユニークで良さそうな反面tooltipが定義されていないWidgetが大半の場合は結構大変そう。
      // というよりこの機会に漏れがちなtooltipをしっかり用意してアクセシビリティを向上させるというのも良いと思う。
      final fab = find.byTooltip('Increment');

      // 今回のケースだと以下でも探せる
      // `find`作業はスクレイピングでDOMの中からHTMLタグを探しに行く作業に近い
      // final fab = find.byKey('increment');

      // インクリメントされる
      await tester.tap(fab);

      // タップ結果のレンダリングが完了するまで待機
      await tester.pumpAndSettle();

      // Incrementタップに寄って内容が変化したことを確認
      expect(find.text('count: 1'), findsOneWidget);
    });
  });
}
