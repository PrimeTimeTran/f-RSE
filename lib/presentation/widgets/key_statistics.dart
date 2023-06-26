import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import 'package:rse/all.dart';

final fakerFa = Faker(provider: FakerDataProviderFa());

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
          const Text(
            'Key Statistics',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

  List<Widget> buildChildren(context) {
    if (isSmall) {
      return [
        Expanded(
          child: Column(
            children: [
              buildDataPoint('Open', formatMoney(asset.o)),
              buildDataPoint('Today\'s high', formatMoney(asset.hiDay)),
              buildDataPoint('Today\'s low', formatMoney(asset.loDay)),
              buildDataPoint('52 Wk high', formatMoney(asset.hiYear)),
              buildDataPoint('52 Wk low', formatMoney(asset.loYear)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              buildDataPoint('Volume', asset.pe.toString()),
              buildDataPoint('Average Volume', '${asset.av} M'),
              buildDataPoint('Market Cap', '${formatMoney(asset.mc)} M'),
              buildDataPoint('P/E Ratio', asset.pe.toString()),
              buildDataPoint('Div/yield', formatPercent(asset.dy)),
            ],
          ),
        ),
      ];
    }
    return [
      Expanded(
        child: Column(
          children: [
            buildDataPoint('Market Cap', '${formatMoney(asset.mc)} M'),
            buildDataPoint('High Today', formatMoney(asset.hiDay)),
            buildDataPoint('52 Week High', formatMoney(asset.hiYear)),
          ],
        ),
      ),
      Expanded(
        child: Column(
          children: [
            buildDataPoint('Price-Earning Ratio', asset.pe.toString()),
            buildDataPoint('Low Today', formatMoney(asset.loDay)),
            buildDataPoint('52 Week Low', formatMoney(asset.loYear)),
          ],
        ),
      ),
      Expanded(
        child: Column(
          children: [
            buildDataPoint('Dividend Yield', formatPercent(asset.dy)),
            buildDataPoint('Open Price', formatMoney(asset.o)),
          ],
        ),
      ),
      Expanded(
        child: Column(
          children: [
            buildDataPoint('Average Volume', '${asset.av} M'),
            buildDataPoint('Volume', '${asset.v} M'),
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
