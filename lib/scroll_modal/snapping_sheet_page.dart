import 'package:flutter/material.dart';
import 'package:flutter_playground/scroll_modal/component/list_view_content.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

// snapping_sheet 2.0.1
// https://pub.dev/packages/snapping_sheet
class SnappingSheetSample extends StatelessWidget {
  const SnappingSheetSample({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SnappingSheet(
        sheetBelow: SnappingSheetContent(
          child: const ListViewContent(),
          heightBehavior: SnappingSheetHeight.fit(),
        ),
        grabbing: GrabSection(),
        grabbingHeight: 60,
        snapPositions: [
          SnapPosition(positionFactor: 0.0),
          SnapPosition(positionFactor: 0.9),
        ],
      ),
    );
  }
}

class GrabSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: .5,
            color: Colors.black.withOpacity(0.2),
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 100.0,
            height: 10.0,
            margin: EdgeInsets.only(top: 15.0),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
          )
        ],
      ),
    );
  }
}
