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
          child: Container(
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('About',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Divider(),
                Text(faker.lorem.sentences(10).join(' ')),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    // color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('CEO',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(asset.company.ceo),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Employees',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(asset.company.ec.toString()),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Headquarters',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(asset.company.hq),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Founded',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                    Text(DateFormat('yyyy').format(asset.company.f))
                              ],

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
