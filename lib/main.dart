import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:rse/data/all.dart';
import 'package:rse/presentation/all.dart';

Future<void> main() async {
  if (!kReleaseMode) {
    await dotenv.load(fileName: ".env");
  }

  Bloc.observer = SimpleBlocObserver();
  HttpOverrides.global = MyHttpOverrides();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: MultiBlocProvider(
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
  int _idx = 0;
  late NewsCubit _newsCubit;
  late AssetCubit _assetCubit;
  late PortfolioCubit _portfolioCubit;

  @override
  void initState() {
    super.initState();
    _newsCubit = context.read<NewsCubit>();
    _portfolioCubit = context.read<PortfolioCubit>();
    _assetCubit = context.read<AssetCubit>();
    fetchData();
  }

  Future<void> fetchData() async {
    _newsCubit.fetchArticles();
    _portfolioCubit.fetchPortfolio("1");
    _assetCubit.fetchAsset("1");
  }

  void change(int idx) {
    setState(() {
      _idx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      title: 'Royal Stock Exchange',
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ThemeModel>(context).isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routes: {
        '/home': (context) => const HomeScreen(title: "RSE"),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: SingleChildScrollView(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: tabs[_idx],
                ),
              ),
              bottomNavigationBar: kIsWeb ? null : BottomTab(change: change, index: _idx),
              appBar: AppBar(
                title: const Text('RSE'),
                actions: navbarIcons(context),
              ),
            ),
            settings: settings,
          );
        } else if (settings.name!.startsWith('/assets/')) {
          final sym = settings.name!.substring('/assets/'.length);
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: SingleChildScrollView(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: AssetScreen(sym: sym),
                ),
              ),
              appBar: AppBar(
                title: const Text('RSE'),
                actions: navbarIcons(context),
              ),
            ),
            settings: settings,
          );
        }
        return null; // Return null for unknown routes
      },
      home: Scaffold(
        drawer: const MyDrawer(),
        body: SingleChildScrollView(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: HomeScreen(title: "RSE")
          ),
        ),
        bottomNavigationBar: kIsWeb ? null : BottomTab(change: change, index: _idx),
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
