import 'dart:io';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'all.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  setupAPP();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PortfolioBloc>(
            create: (_) => PortfolioBloc(portfolio: Portfolio.defaultPortfolio()),
          ),
          BlocProvider<NewsBloc>(
            create: (_) => NewsBloc(),
          ),
          BlocProvider<AssetBloc>(
            create: (_) => AssetBloc(asset: Asset.defaultAsset()),
          ),
          BlocProvider<ChartBloc>(
            create: (context) {
              final assetBloc = BlocProvider.of<AssetBloc>(context);
              final portfolioBloc = BlocProvider.of<PortfolioBloc>(context);
              return ChartBloc(chart: Chart(), assetBloc: assetBloc, portfolioBloc: portfolioBloc);
            },
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late NewsBloc _newsBloc;
  late AssetBloc _assetBloc;

  @override
  void initState() {
    super.initState();
    _newsBloc = context.read<NewsBloc>();
    _assetBloc = context.read<AssetBloc>();
    fetchData();
  }

  Future<void> fetchData() async {
    _newsBloc.fetchArticles();
    _assetBloc.fetchAsset("GOOGL");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: goRouter,
      title: 'Royal Stock Exchange',
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ThemeModel>(context).isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
