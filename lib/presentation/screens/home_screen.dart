import 'package:flutter/material.dart';

import 'package:rse/presentation/all.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TickerCarousel(),
            ResponsiveLayout(),
          ],
        ),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return buildOneColumn(context);
          } else {
            return buildTwoColumn();
          }
        },
      ),
    );
  }

  Widget buildOneColumn(context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          LineChart(),
          Articles(),
        ],
      ),
    );
  }

  Widget buildTwoColumn() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  LineChart(),
                  Articles(),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Watchlist(),
          ),
        ],
      ),
    );
  }
}
