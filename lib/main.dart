import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/cubits/all.dart';
import 'package:rse/presentation/navigation/all.dart';
import 'package:rse/presentation/utils/constants.dart' as constants;

void main() {
  Bloc.observer = SimpleBlocObserver();
  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PortfolioCubit>(
          create: (_) => PortfolioCubit(),
        ),
        BlocProvider<NewsCubit>(
          create: (_) => NewsCubit(),
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
        drawer: const Drawerr(),
        body: constants.tabs[_idx],
        bottomNavigationBar: BottomTab(change: change, index: _idx),
        appBar: AppBar(
          title: const Text('RSE'),
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
