import 'package:flutter/material.dart';

class BottomTab extends StatefulWidget {
  final Function(int) change;
  final int index;

  const BottomTab({required this.change, required this.index, Key? key})
      : super(key: key);

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  @override
  Widget build(BuildContext context) {
    final primarySwatch = Theme.of(context).primaryColor;
    final unselectedLabelColor = Theme.of(context).bottomAppBarTheme.color;

    return BottomNavigationBar(
      currentIndex: widget.index,
      fixedColor: primarySwatch,
      showUnselectedLabels: true,
      onTap: (idx) => widget.change(idx),
      unselectedItemColor: unselectedLabelColor,
      unselectedLabelStyle: TextStyle(color: unselectedLabelColor),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: 'Stocks',
          icon: Icon(Icons.auto_graph),
        ),
        BottomNavigationBarItem(
          label: 'Spending',
          icon: Icon(Icons.credit_card),
        ),
        BottomNavigationBarItem(
          label: 'Browse',
          icon: Icon(Icons.newspaper),
        ),
        BottomNavigationBarItem(
          label: 'News',
          icon: Icon(Icons.newspaper),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(Icons.person_2_outlined),
        ),
      ],
    );
  }
}
