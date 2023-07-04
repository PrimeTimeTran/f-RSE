import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:rse/all.dart';

class BottomNavBar extends StatelessWidget {
  final StatefulNavigationShell shell;
  final Function resetStack;

  const BottomNavBar({super.key, required this.shell, required this.resetStack});

  void _goBranch(int index) {
    resetStack(index);
  }

  getIconColor(context, idx) {
    return shell.currentIndex == idx
        ? T(context, 'primaryContainer')
        : T(context, 'inversePrimary');
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: _goBranch,
      selectedIndex: shell.currentIndex,
      indicatorColor: Theme.of(context).indicatorColor,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      destinations: [
        NavigationDestination(
          label: 'Home',
          icon: Icon(
            Icons.home,
            color: getIconColor(context, 0),
          ),
        ),
        NavigationDestination(
          label: 'Investing',
          icon: Icon(
            Icons.candlestick_chart,
            color: getIconColor(context, 1),
          ),
        ),
        NavigationDestination(
          label: 'Notifications',
          icon: Icon(
            Icons.notifications,
            color: getIconColor(context, 2),
          ),
        ),
        NavigationDestination(
          label: 'Profile',
          icon: Icon(
            Icons.person,
            color: getIconColor(context, 3),
          ),
        ),
      ],
    );
  }
}
