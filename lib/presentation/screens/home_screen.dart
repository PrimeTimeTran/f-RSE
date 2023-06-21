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
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TickerCarousel(),
              ResponsiveLayout(),
            ],
          ),
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
            return buildTwoColumn(context);
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

  Widget buildTwoColumn(context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 60),
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
          Watchlist(),
        ],
      ),
    );
  }
}
