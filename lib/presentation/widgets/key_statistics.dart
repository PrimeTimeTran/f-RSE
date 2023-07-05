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
              buildDataPoint('Open', formatMoney(asset.meta.o)),
              buildDataPoint('Today\'s high', formatMoney(asset.meta.hiDay)),
              buildDataPoint('Today\'s low', formatMoney(asset.meta.loDay)),
              buildDataPoint('52 Wk high', formatMoney(asset.meta.hiYear)),
              buildDataPoint('52 Wk low', formatMoney(asset.meta.loYear)),
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
            buildDataPoint('Market Cap', '${formatMoney(asset.meta.mc)} M'),
            buildDataPoint('High Today', formatMoney(asset.meta.hiDay)),
            buildDataPoint('52 Week High', formatMoney(asset.meta.hiYear)),
          ],
        ),
      ),
      Expanded(
        child: Column(
          children: [
            buildDataPoint('Price-Earning Ratio', asset.meta.pe.toString()),
            buildDataPoint('Low Today', formatMoney(asset.meta.loDay)),
            buildDataPoint('52 Week Low', formatMoney(asset.meta.loYear)),
          ],
        ),
      ),
      Expanded(
        child: Column(
          children: [
            buildDataPoint('Dividend Yield', formatPercent(asset.meta.dy)),
            buildDataPoint('Open Price', formatMoney(asset.meta.o)),
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
