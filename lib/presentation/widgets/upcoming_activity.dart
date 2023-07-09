import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class UpcomingActivity extends StatelessWidget {
  const UpcomingActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l.upcoming_activity,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Upcoming item $index'),
                  subtitle: const Text('Tap here to go back'),
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
