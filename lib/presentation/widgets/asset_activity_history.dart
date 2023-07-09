import 'package:flutter/material.dart';

import 'package:rse/all.dart';

class AssetActivityHistory extends StatelessWidget {
  final Asset asset;
  const AssetActivityHistory({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l.history, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const Divider(),
        SizedBox(
          height: 100,
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Activity $index'),
              );
            },
          ),
        ),
      ],
    );
  }
}