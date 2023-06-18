import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/cubits/all.dart';
import 'package:rse/presentation/widgets/all.dart';
import 'package:rse/presentation/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late NewsCubit _newsCubit;
  late PortfolioCubit _portfolioCubit;

  @override
  void initState() {
    super.initState();
    _newsCubit = context.read<NewsCubit>();
    _portfolioCubit = context.read<PortfolioCubit>();
    fetchData();
  }

  Future<void> fetchData() async {
    _newsCubit.fetchArticles();
    _portfolioCubit.fetchPortfolio("1");
  }

  @override
  void dispose() {
    _newsCubit.close();
    _portfolioCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Center(
      child: Column(
        children: [
          TickerCarousel(),
          PortfolioLineChart(),
          Padding(
            padding: isWeb ? EdgeInsets.only(left: 50.0, right: 50) : EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Articles(),
                Watchlist(),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
