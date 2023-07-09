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
          buildOverview(
            context,
            context.l.your_market_value,
            context.l.todays_return,
            context.l.total_return,
          ),
          const Text('   '),
          buildOverview(
            context,
            context.l.your_average_cost,
            context.l.shares,
            context.l.portfolio_diversity,
          ),
        ],
      ),
    );
  }

  Expanded buildOverview(BuildContext context, title, info1, info2) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            width: 1,
            color: Colors.grey[500]!,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: getFontSize(context),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      '\$100,000',
                      style: TextStyle(
                        fontSize: getFontSize(context) * 2,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    info1,
                    style: TextStyle(
                      fontSize: getFontSize(context),
                    ),
                  ),
                  Text(
                    '\$100,000',
                    style: TextStyle(
                      fontSize: getFontSize(context),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    info2,
                    style: TextStyle(
                      fontSize: getFontSize(context),
                    ),
                  ),
                  Text(
                    '\$100,000',
                    style: TextStyle(
                      fontSize: getFontSize(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
