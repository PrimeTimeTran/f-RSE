import 'package:flutter/material.dart';
import 'package:rse/presentation/screens/all.dart';

const api = "https://192.168.0.22:7254";
const newsApi = "https://newsdata.io/api/1/news?apikey=1&q=business";

const List<Widget> tabs = [
  HomeScreen(title: 'Home'),
  InvestingScreen(title: 'Spending'),
  TabScreen(title: 'Explore'),
  TabScreen(title: 'News'),
  TabScreen(title: 'Profile'),
];

class TabScreen extends StatelessWidget {
  final String title;

  const TabScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}


