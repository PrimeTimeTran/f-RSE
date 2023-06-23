import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/cubits/portfolio_cubit.dart';
import 'package:rse/presentation/all.dart';

class InvestingSummaryScreen extends StatefulWidget {
  final String title;

  const InvestingSummaryScreen({Key? key, required this.title}) : super(key: key);

  @override
  InvestingSummaryScreenState createState() => InvestingSummaryScreenState();
}

class InvestingSummaryScreenState extends State<InvestingSummaryScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTabContainer(context);
  }

  SingleChildScrollView buildSingleChildScrollView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 50),
        child: Center(
          child: Column(
            children: [
              BlocConsumer<PortfolioCubit, PortfolioState>(
                builder: (context, state) {
                  if (state is PortfolioLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is PortfolioLoaded) {
                    final p = state.portfolio;
                    return Column(
                      children: [
                        InvestmentGroup(
                          title: 'Stocks',
                          current: p.current,
                          num: p.stocks.length,
                          securities: p.stocks
                        ),
                        InvestmentGroup(
                          title: 'Cryptos',
                          current: p.current,
                          num: p.cryptos.length,
                          securities: p.cryptos
                        ),
                      ],
                    );
                  } else if (state is PortfolioError) {
                    return Text('Error: ${state.errorMessage}');
                  } else {
                    return const Text('Unknown state');
                  }
                },
                listener: (context, state) {
                  // Listener logic goes here if needed
                },
                buildWhen: (previous, current) {
                  return true;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContainer(context) {
    final color = T(context, 'primary');
    final unselectedColor = T(context, 'inversePrimary');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DefaultTabController(
        length: 12,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TabBar(
                labelColor: color,
                indicatorColor: color,
                isScrollable: isS(context),
                unselectedLabelColor: unselectedColor,
                tabs: const [
                  Tab(text: 'Investing'),
                  Tab(text: 'Spending'),
                  Tab(text: 'Crypto'),
                  Tab(text: 'Transfers'),
                  Tab(text: 'Recurring'),
                  Tab(text: 'Stock Lending'),
                  Tab(text: 'Margin Investing'),
                  Tab(text: 'Reports & Statements'),
                  Tab(text: 'Tax Center'),
                  Tab(text: 'History'),
                  Tab(text: 'Settings'),
                  Tab(text: 'Help'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    buildSingleChildScrollView(),
                    const Text('Spending'),
                    const Text('Crypto'),
                    const Text('Transfers'),
                    const Text('Recurring'),
                    const Text('Stock Lending'),
                    const Text('Margin Investing'),
                    const Text('Reports & Statements'),
                    const Text('Tax Center'),
                    const Text('History'),
                    const Text('Settings'),
                    const Text('Help'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

