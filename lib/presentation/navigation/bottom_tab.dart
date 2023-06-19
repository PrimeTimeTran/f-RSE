import 'package:flutter/material.dart';

import 'package:rse/presentation/all.dart';

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
    final unselectedLabelColor = T(context, 'inversePrimary');

    return BottomNavigationBar(
      currentIndex: widget.index,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: (idx) => widget.change(idx),
      unselectedItemColor: unselectedLabelColor,
      selectedItemColor: T(context, 'primary'),
      unselectedLabelStyle: TextStyle(color: unselectedLabelColor),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: 'Stocks',
          backgroundColor: T(context, 'background'),
          icon: Icon(Icons.auto_graph),
        ),
        BottomNavigationBarItem(
          label: 'Spending',
          backgroundColor: T(context, 'background'),
          icon: Icon(Icons.credit_card),
        ),
        BottomNavigationBarItem(
          label: 'Browse',
          backgroundColor: T(context, 'background'),
          icon: Icon(Icons.newspaper),
        ),
        BottomNavigationBarItem(
          label: 'News',
          backgroundColor: T(context, 'background'),
          icon: Icon(Icons.newspaper),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          backgroundColor: T(context, 'background'),
          icon: Icon(Icons.person_2_outlined),
        ),
      ],
    );
  }
}
