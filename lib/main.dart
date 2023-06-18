import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/cubits/all.dart';
import 'package:rse/presentation/navigation/all.dart';
import 'package:rse/presentation/navigation/navbar_icons.dart';
import 'package:rse/presentation/utils/constants.dart' as constants;

Future<void> main() async {
  if (!kReleaseMode) {
    await dotenv.load(fileName: ".env");
  }

  Bloc.observer = SimpleBlocObserver();
  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NewsCubit>(
          create: (_) => NewsCubit(),
        ),
        BlocProvider<PortfolioCubit>(
          create: (_) => PortfolioCubit(),
        ),
        BlocProvider<AssetCubit>(
          create: (_) => AssetCubit(),
        ),
        BlocProvider<ChartCubit>(
          create: (_) => ChartCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _idx = 0;
  late NewsCubit _newsCubit;
  late PortfolioCubit _portfolioCubit;
  late AssetCubit _assetCubit;
  late ChartCubit _chartCubit;

  @override
  void initState() {
    super.initState();
    _newsCubit = context.read<NewsCubit>();
    _portfolioCubit = context.read<PortfolioCubit>();
    _assetCubit = context.read<AssetCubit>();
    _chartCubit = context.read<ChartCubit>();
    fetchData();
  }

  Future<void> fetchData() async {
    _newsCubit.fetchArticles();
    _portfolioCubit.fetchPortfolio("1");
    _assetCubit.fetchAsset("1");
    _chartCubit.initializeChartCandle();
  }

  void change(int idx) {
    setState(() {
      _idx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Royal Stock Exchange',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        drawer: const MyDrawer(),
        body: constants.tabs[_idx],
        bottomNavigationBar: BottomTab(change: change, index: _idx),
        appBar: AppBar(
          title: const Text('RSE'),
          actions: navbarIcons(context),
        ),
      ),
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
  }
}
