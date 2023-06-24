import 'package:flutter/material.dart';

import 'package:rse/all.dart';

class ChartHeaderDetails extends StatelessWidget {
  final double startValue;
  final String gain;
  final String title;
  final double cursorVal;

  const ChartHeaderDetails({
    super.key,
    required this.gain,
    required this.title,
    required this.cursorVal,
    required this.startValue,
  });

  @override
  Widget build(BuildContext context) {
    final gained = getChangePercent(cursorVal, startValue) > 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: T(context, 'inversePrimary'),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            formatMoney(cursorVal),
            style: TextStyle(
              color: T(context, 'inversePrimary'),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            '${calculateValueChange(cursorVal, startValue)} ($gain)',
            style: TextStyle(
              color: gained ? T(context, 'primary') : Colors.red,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
