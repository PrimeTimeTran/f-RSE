
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import 'package:rse/presentation/all.dart';

class UpcomingActivity extends StatefulWidget {
  const UpcomingActivity({super.key});

  @override
  State<UpcomingActivity> createState() => _UpcomingActivityState();
}

class _UpcomingActivityState extends State<UpcomingActivity> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Upcoming Activity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(),
          Container(
            height: 100,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Upcoming item $index'),
                  subtitle: const Text('Tap here to go back'),
                  // tileColor: Colors.blue[700],
                  onTap: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}