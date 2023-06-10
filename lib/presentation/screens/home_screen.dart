import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/cubits/all.dart';
import 'package:rse/data/models/all.dart' as models;
import 'package:rse/presentation/widgets/all.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              BlocConsumer<PortfolioCubit, PortfolioState>(
                builder: (context, state) {
                  if (state is PortfolioLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is PortfolioLoaded) {
                    final dataPoints = context.read<PortfolioCubit>().dataPoints;
                    return Column(
                      children: [
                        LineChart(data: dataPoints),
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
              BlocBuilder<NewsCubit, List<models.Article>>(
                builder: (context, articles) {
                  if (articles.isEmpty) {
                    return const CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return Article(article: articles[index]);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        )
    );
  }
}

