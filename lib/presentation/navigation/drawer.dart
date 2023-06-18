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
    Color primarySwatch = Theme.of(context).primaryColor;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: primarySwatch,
            ),
            child: const Text(
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
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text('Spending'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/go');
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
