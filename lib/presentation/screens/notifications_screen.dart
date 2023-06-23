import 'package:flutter/material.dart';

import 'package:rse/presentation/all.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: buildMobile(context),
        desktop: buildDesktop(context),
      ),
    );
  }

  allNotifications(context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Notifications",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Notifications $index"),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildMobile(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          // color: Colors.red,
          child: allNotifications(context)
        ),
      ),
    );
  }

  securityNotifications(context) {
    return Expanded(
      flex: 5,
      child: Column(
        children: [
          const Align(
            child: Text(
              "Name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Message $index"),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildDesktop(BuildContext context) {
    return Container(
      // color: Colors.blue,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            allNotifications(context),
            securityNotifications(context),
          ],
        ),
      ),
    );
  }
}
