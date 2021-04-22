import 'package:flutter/material.dart';
import 'package:flutter_playground/scroll_modal/component/list_view_content.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

// sliding_sheet 0.4.0
// https://pub.dev/packages/sliding_sheet
class SlidingSheetWidgetPage extends StatelessWidget {
  const SlidingSheetWidgetPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1!;

    return Scaffold(
      appBar: AppBar(),
      body: SlidingSheet(
        elevation: 8,
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.2, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        builder: (context, state) => const SizedBox(
          height: 600, // 高さの指定がやりにくい
          child: Padding(
            padding: EdgeInsets.only(bottom: 56),

            /// SlidingSheetのScrollControllerを使うので
            /// スクロール系のWidgetの場合は自身のScrollイベントをDisableにしておく必要がある
            /// さもないと下スワイプで画面を閉じてくれなくなる
            child: ListViewContent(physics: NeverScrollableScrollPhysics()),
          ),
        ),
        headerBuilder: (context, state) {
          return Container(
            height: 56,
            width: double.infinity,
            color: Colors.green,
            alignment: Alignment.center,
            child: Text(
              'This is the header',
              style: textStyle.copyWith(color: Colors.white),
            ),
          );
        },
        footerBuilder: (context, state) {
          return Container(
            height: 56,
            width: double.infinity,
            color: Colors.yellow,
            alignment: Alignment.center,
            child: Text(
              'This is the footer',
              style: textStyle.copyWith(color: Colors.black),
            ),
          );
        },
      ),
    );
  }
}
