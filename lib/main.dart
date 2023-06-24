import 'dart:io';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:rse/all.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: "/assets/.env");
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
