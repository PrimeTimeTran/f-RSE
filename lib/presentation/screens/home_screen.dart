import 'package:flutter/material.dart';

import 'package:rse/all.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.label, Key? key}) : super(key: key);

  final String label;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>  with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setScreenName('home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: buildMobile(context),
        desktop: buildDesktop(context),
      ),
    );
  }

  Widget mobileWatchList(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: watched.length,
        itemBuilder: (BuildContext context, int index) {
          final item = watched[index];
          return WatchItem(item);
        },
      ),
    );
  }

  Widget buildMobile(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LineChart(),
          mobileWatchList(context),
          const Articles(),
        ],
      ),
    );
  }

  Widget buildDesktop(context) {
    return Row(
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const TickerCarousel(),
                  LineChart(),
                  const Articles(),
                ],
              ),
            ),
          ),
        ),
        const Watchlist(),
      ],
    );
  }
}
