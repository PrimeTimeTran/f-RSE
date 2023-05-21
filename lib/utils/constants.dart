import 'package:flutter/material.dart';
import 'package:rse/screens/home_screen.dart';

class TabScreen extends StatelessWidget {
  final String title;

  const TabScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(this.title),
    );
  }
}

const List<Widget> TABS = [
  HomeScreen(title: 'Home'),
  TabScreen(title: 'Tab 2'),
  TabScreen(title: 'Tab 3'),
];
