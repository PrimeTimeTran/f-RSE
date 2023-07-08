import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'package:rse/presentation/all.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => DrawerState();
}

class DrawerState extends State<MyDrawer> {
  late bool isDark = isDarkMode(context);

  void toggleTheme(themeModel) {
    setState(() {
      isDark = !isDark;
    });
    themeModel.toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Container(
          color: T(context, 'primaryContainer').withOpacity(0.7),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      color: Colors.grey[900],
                      child: const DrawerHeader(
                        decoration: BoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Royal Stock Exchange',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            CircleAvatar(
                              radius: 50,
                              //Image from url
                              backgroundImage: NetworkImage(
                                  "https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        ListTile(
                          title: const Text('Investing'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text('Watch'),
                          onTap: () {},
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ListTile(
                          title: const Text('Account'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text('Settings'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Consumer<ThemeModel>(
                          builder: (context, themeModel, _) {
                            return Toggler(
                              initialValue: isDark,
                              onChanged: (newValue) {
                                toggleTheme(themeModel);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: T(context, 'inversePrimary'),
                    thickness: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextButton(

                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(

                          vertical: 10,
                          horizontal: 10,
                        ),
                        side: BorderSide(
                          width: 1,
                          color: T(context, 'onError'),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: T(context, 'primaryContainer'),
                      ),
                      child: Text(
                        'Sign out',
                        style: TextStyle(
                          fontSize: 16,
                          color: T(context, 'onError'),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
