import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rse/presentation/all.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => DrawerState();
}

class DrawerState extends State<MyDrawer> {
  int _idx = 0;
  late bool isDark = isDarkMode(context);
  @override
  Widget build(BuildContext context) {
    final color = T(context, 'primary');
    var dark = isDarkMode(context);
    return Drawer(
      child: Consumer<ThemeModel> (
        builder: (context, themeModel, _) {
          return ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: color,
                ),
                child: const Text(
                  'Royal Stock Exchange',
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
              ListTile(
                title: const Text('Gold'),
                onTap: () {
                  setState(() {
                    _idx = 2;
                  });
                  Navigator.pop(context);
                },
              ),
              Toggler(
                initialValue: dark,
                onChanged: (value) {
                setState(() {
                  isDark = value;
                  themeModel.toggleTheme();
                });
              }),
            ],
          );
        }
      ),
    );
  }
}
