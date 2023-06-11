import 'package:flutter/material.dart';
import 'package:rse/presentation/screens/all.dart';

const api = "https://192.168.0.22:7254";
const newsApi = "https://newsdata.io/api/1/news?apikey=1&category=business&language=en";

const investmentTypes = ['Stocks', 'Options', 'Cryptos'];

const List<Widget> tabs = [
  HomeScreen(title: 'Home'),
  InvestingSummaryScreen(title: 'Spending'),
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


