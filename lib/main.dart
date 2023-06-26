import 'dart:io';
import 'dart:ui';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:rse/all.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } catch (e) {
    print('Error Firebase $e');
  }

  // await dotenv.load(fileName: "/assets/.env");

  HttpOverrides.global = MyHttpOverrides();

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
            create: (_) => ChartBloc(chart: Chart()),
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
  late PortfolioBloc _portfolioBloc;

  @override
  void initState() {
    super.initState();
    _newsBloc = context.read<NewsBloc>();
    _portfolioBloc = context.read<PortfolioBloc>();
    _assetBloc = context.read<AssetBloc>();
    fetchData();
  }

  Future<void> fetchData() async {
    _newsBloc.fetchArticles();
    _portfolioBloc.fetchPortfolio("1");
    _assetBloc.fetchAsset("GOOGL");
    event();
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
