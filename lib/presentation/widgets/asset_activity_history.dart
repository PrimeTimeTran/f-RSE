import 'package:flutter/material.dart';

import 'package:rse/all.dart';

class AssetActivityHistory extends StatelessWidget {
  const AssetActivityHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('History'),
          Container(
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
      ),
    );
  }
}