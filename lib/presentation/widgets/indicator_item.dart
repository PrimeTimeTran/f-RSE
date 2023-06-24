import 'package:flutter/material.dart';

import 'package:rse/all.dart';

class IndicatorItem extends StatelessWidget {
  final String title;
  final double price;

  const IndicatorItem(this.price, this.title, {super.key});

  getTextSize(context) {
    if (isS(context)) {
      return 10.0;
    } else if (isM(context)) {
      return 10.0;
    } else if (isL(context)) {
      return 16.0;
    }
    return 16.0;
  }

  @override
  Widget build(BuildContext context) {
    final small = isS(context);
    if (small) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            Text(
              formatMoney(price.toString()),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: getTextSize(context),),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          Text(
            formatMoney(price.toString()),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: getTextSize(context)),
          ),
        ],
      ),
    );
  }
}
