import 'package:flutter/material.dart';
import 'package:flutter_playground/scroll_modal/component/list_view_content.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

// snapping_sheet 2.1
// https://pub.dev/packages/snapping_sheet
class SnappingSheetSamplePage extends StatelessWidget {
  const SnappingSheetSamplePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SnappingSheet(
        sheetBelow: SnappingSheetContent(
          child: const ListViewContent(),
        ),
        grabbing: GrabSection(),
        grabbingHeight: 60,
        snappingPositions: const [
          SnappingPosition.factor(positionFactor: 0),
          SnappingPosition.factor(positionFactor: 0.9),
        ],
        child: const SizedBox.shrink(),
      ),
    );
  }
}

class GrabSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(30);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: .5,
            color: Colors.black.withOpacity(0.2),
          )
        ],
        borderRadius: const BorderRadius.only(
          topLeft: borderRadius,
          topRight: borderRadius,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 100,
            height: 10,
            margin: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
