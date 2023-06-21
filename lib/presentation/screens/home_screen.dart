import 'package:flutter/material.dart';
import 'package:rse/presentation/all.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  final String label;
  final String detailsPath;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: buildMobile(context),
        desktop: buildDesktop(context),
      ),
    );
  }

  Widget buildMobile(context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          LineChart(),
          Articles(),
        ],
      ),
    );
  }

  Widget buildDesktop(context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    TickerCarousel(),
                    LineChart(),
                    Articles(),
                  ],
                ),
              ),
            ),
          ),
          const Watchlist(),
        ],
      ),
    );
  }
}


