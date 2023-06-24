import 'package:flutter/material.dart';

import 'package:rse/all.dart';

class YourPosition extends StatelessWidget {
  const YourPosition({super.key});

  getFontSize(context) {
    if (isS(context)) {
      return 10.0;
    } else if (isM(context)) {
      return 12.0;
    } else if (isL(context)) {
      return 15.0;
    } else if (isXL(context)) {
      return 10.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: T(context, 'inversePrimary'),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Your Market Value', style: TextStyle(fontSize: getFontSize(context)))
                      ],
                    ),
                    Row(
                      children: [
                        Text('\$100,000', style: TextStyle(fontSize: getFontSize(context) * 1.3, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Todays Return', style: TextStyle(fontSize: getFontSize(context)),),
                        Text('\$100,000', style: TextStyle(fontSize: getFontSize(context)),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Return', style: TextStyle(fontSize: getFontSize(context)),),
                        Text('\$100,000', style: TextStyle(fontSize: getFontSize(context)),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: T(context, 'inversePrimary'),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Your Average Cost', style: TextStyle(fontSize: getFontSize(context)))
                        ],
                      ),
                      Row(
                        children: [
                          Text('\$100,000', style: TextStyle(fontSize: getFontSize(context) * 1.3, fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Shares', style: TextStyle(fontSize: getFontSize(context)),),
                          Text('\$100,000', style: TextStyle(fontSize: getFontSize(context)),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Portfolio Diversity', style: TextStyle(fontSize: getFontSize(context)),),
                          Text('\$100,000', style: TextStyle(fontSize: getFontSize(context)),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}