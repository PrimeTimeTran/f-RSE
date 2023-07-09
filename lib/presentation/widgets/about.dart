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
              Text(
                context.l.about,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

  List<Widget> buildChildren(BuildContext context) {
    if (isS(context)) {
      return [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDataPoint(context.l.ceo, asset.company.ceo, true),
              buildDataPoint(
                context.l.employees,
                asset.company.ec.toString(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDataPoint(context.l.headquarters, asset.company.hq, true),
              buildDataPoint(
                context.l.employees,
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
          context.l.employees,
          asset.company.ec.toString(),
        ),
      ),
      Expanded(
        child: buildDataPoint(
          context.l.headquarters,
          asset.company.hq,
        ),
      ),
      Expanded(
        child: buildDataPoint(
          context.l.founded,
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
