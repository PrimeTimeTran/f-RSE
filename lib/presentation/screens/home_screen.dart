import 'package:flutter/material.dart';

import 'package:rse/all.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.label, Key? key})
      : super(key: key);

  final String label;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late bool lock = true;
  @override
  void initState() {
    super.initState();
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

  Widget buildMobile(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LineChart(
            lock: lock,
            lockFlag: lockFlag,
            unLockFlag: unLockFlag,
          ),
          const Articles(),
        ],
      ),
    );
  }
  unLockFlag(some) {
    setState(() {
      lock = true;
    });
  }
  lockFlag(other) {
    setState(() {
      lock = true;
    });
  }
  Widget buildDesktop(context) {
    return Row(
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const TickerCarousel(),
                  MouseRegion(
                    onEnter: (event) => unLockFlag(false),
                    onExit: (event) => lockFlag(true),
                    child: LineChart(
                      lock: lock,
                      lockFlag: lockFlag,
                      unLockFlag: unLockFlag,
                    )
                  ),
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


