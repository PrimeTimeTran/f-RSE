import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';

import 'package:rse/all.dart';

class About extends StatelessWidget {
  final Asset asset;

  const About({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'About',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Text(faker.lorem.sentences(10).join(' ')),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: buildChildren(context),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  List<Widget> buildChildren(context) {
    if (isS(context)) {
      return [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDataPoint('CEO', asset.company.ceo, true),
              buildDataPoint(
                'Employees',
                asset.company.ec.toString(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDataPoint('Headquarters', asset.company.hq, true),
              buildDataPoint(
                'Employees',
                DateFormat('yyyy').format(asset.company.f),
              ),
            ],
          ),
        ),
      ];
    }
    return [
      Expanded(child: buildDataPoint('CEO', asset.company.ceo)),
      Expanded(
        child: buildDataPoint(
          'Employees',
          asset.company.ec.toString(),
        ),
      ),
      Expanded(
        child: buildDataPoint(
          'Headquarters',
          asset.company.hq,
        ),
      ),
      Expanded(
        child: buildDataPoint(
          'Founded',
          DateFormat('yyyy').format(asset.company.f),
        ),
      ),
    ];
  }

  buildDataPoint(String title, value, [big = false]) {
    return SizedBox(
      height: big ? 70 : 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
