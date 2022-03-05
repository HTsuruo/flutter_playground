import 'package:flutter/material.dart';

class PagingIndicator extends StatelessWidget {
  const PagingIndicator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 16),
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
      ],
    );
  }
}
