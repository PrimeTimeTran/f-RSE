import 'package:flutter/material.dart';
import 'package:rse/presentation/screens/all.dart';
import 'package:rse/presentation/screens/notifications_screen.dart';
import 'package:rse/presentation/screens/spending_screen.dart';

const api = "http://localhost:7254";
const newsApi =
    "https://newsdata.io/api/1/news?apikey=1&category=business&language=en";

const investmentTypes = ['Stocks', 'Options', 'Cryptos'];

const List<Widget> tabs = [
  HomeScreen(title: 'Home'),
  InvestingSummaryScreen(title: 'Spending'),
  NotificationsScreen(),
  SpendingScreen(),
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
