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
    return BottomNavigationBar(
      currentIndex: widget.index,
      onTap: (index) {
        setState(() {
          widget.change(index);
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_graph),
          label: 'Stocks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Crypto',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Profile',
        ),
      ],
    );
  }
}
