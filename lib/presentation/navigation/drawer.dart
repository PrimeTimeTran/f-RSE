import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => DrawerState();
}

class DrawerState extends State<MyDrawer> {
  int _idx = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Investing'),
            onTap: () {
              setState(() {
                _idx = 0;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Spending'),
            onTap: () {
              setState(() {
                _idx = 1;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Crypto'),
            onTap: () {
              setState(() {
                _idx = 2;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Transfers'),
            onTap: () {
              setState(() {
                _idx = 2;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Gold'),
            onTap: () {
              setState(() {
                _idx = 2;
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
