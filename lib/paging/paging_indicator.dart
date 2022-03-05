import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PagingIndicator extends StatelessWidget {
  const PagingIndicator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
        Gap(16),
      ],
    );
  }
}
