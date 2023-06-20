import 'package:flutter/material.dart';
import 'package:rse/presentation/screens/all.dart';

const investmentTypes = ['Stocks', 'Options', 'Cryptos'];

const List<Widget> tabs = [
  HomeScreen(title: 'Home'),
  InvestingSummaryScreen(title: 'Spending'),
  NotificationsScreen(),
  SpendingScreen(),
  AssetScreen(sym: 'BAC'),
];