import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import 'package:rse/all.dart';

final fakerFa = Faker(provider: FakerDataProviderFa());

// ignore: must_be_immutable
class KeyStatistics extends StatelessWidget {
  late bool isSmall;
  final Asset asset;

  KeyStatistics({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    isSmall = isS(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l.key_statistics,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildChildren(context),
          ),
        ],
      ),
    );
  }

  List<Widget> buildChildren(BuildContext context) {
    if (isSmall) {
      return [
        Expanded(
          child: Column(
            children: [
              buildDataPoint(context.l.open, formatMoney(asset.meta.o)),
              buildDataPoint(context.l.todays_high, formatMoney(asset.meta.hiDay)),
              buildDataPoint(context.l.todays_low, formatMoney(asset.meta.loDay)),
              buildDataPoint(context.l.fifty_two_week_hi, formatMoney(asset.meta.hiYear)),
              buildDataPoint(context.l.fifty_two_week_lo, formatMoney(asset.meta.loYear)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              buildDataPoint('Volume', asset.meta.pe.toString()),
              buildDataPoint('Average Volume', '${asset.meta.av} M'),
              buildDataPoint('Market Cap', '${formatMoney(asset.meta.mc)} M'),
              buildDataPoint('P/E Ratio', asset.meta.pe.toString()),
              buildDataPoint('Div/yield', formatPercent(asset.meta.dy)),
            ],
          ),
        ),
      ];
    }
    return [
      Expanded(
        child: Column(
          children: [
            buildDataPoint(context.l.market_cap, '${formatMoney(asset.meta.mc)} M'),
            buildDataPoint(context.l.todays_high, formatMoney(asset.meta.hiDay)),
            buildDataPoint(context.l.fifty_two_week_hi, formatMoney(asset.meta.hiYear)),
          ],
        ),
      ),
      Expanded(
        child: Column(
          children: [
            buildDataPoint('Price-Earning Ratio', asset.meta.pe.toString()),
            buildDataPoint(context.l.todays_low, formatMoney(asset.meta.loDay)),
            buildDataPoint(context.l.fifty_two_week_lo, formatMoney(asset.meta.loYear)),
          ],
        ),
      ),
      Expanded(
        child: Column(
          children: [
            buildDataPoint('Dividend Yield', formatPercent(asset.meta.dy)),
            buildDataPoint(context.l.open, formatMoney(asset.meta.o)),
          ],
        ),
      ),
      Expanded(
        child: Column(
          children: [
            buildDataPoint('Average Volume', '${asset.meta.av} M'),
            buildDataPoint('Volume', '${asset.meta.v} M'),
          ],
        ),
      ),
    ];
  }

  Padding buildDataPoint(title, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Text(
              value,
              style: TextStyle(fontSize: isSmall ? 16 : 12),
            ),
          ),
        )
      ]),
    );
  }
}
