import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rse/presentation/screens/all.dart';
import 'package:rse/presentation/screens/notifications_screen.dart';
import 'package:rse/presentation/screens/spending_screen.dart';

const api = "http://localhost:7254";

String? apiKey = dotenv.env['API_KEY'];
late String newsApi;

void initializeNewsApi() {
  newsApi =
      "https://newsdata.io/api/1/news?category=business&language=en&${apiKey ?? ''}";
}

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
    initializeNewsApi();
    return Center(
      child: Text(title),
    );
  }
}
