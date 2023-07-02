import 'package:flutter/material.dart';

import 'package:rse/presentation/all.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => DrawerState();
}

class DrawerState extends State<MyDrawer> {
  late bool isDark = isDarkMode(context);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Drawer Item 1'),
            onTap: () {
            },
          ),
          ListTile(
            title: const Text('Drawer Item 2'),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
