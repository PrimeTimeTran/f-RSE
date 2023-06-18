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

    return BottomNavigationBar(
      currentIndex: widget.index,
      onTap: (idx) => widget.change(idx),
      selectedItemColor: primarySwatch,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: 'Stocks',
          icon: Icon(Icons.auto_graph),
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          label: 'Spending',
          icon: Icon(Icons.credit_card),
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          label: 'Browse',
          icon: Icon(Icons.newspaper),
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          label: 'News',
          icon: Icon(Icons.newspaper),
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(Icons.person_2_outlined),
          backgroundColor: Colors.black,
        ),
      ],
    );
  }
}
