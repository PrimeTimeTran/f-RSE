// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/mock_nav_bloc.dart';
import 'mocks/mock_firebase.dart';
import 'mocks/mock_news_bloc.dart';
import 'mocks/mock_asset_bloc.dart';
import 'mocks/mock_portfolio_bloc.dart';

import 'package:rse/all.dart';

void main() {
  setUp(() async {
    // await setup();
    setupFirebaseAnalyticsMocks();
  });

  tearDown(() {
    // Clean up any resources or reset any state if needed
  });

  testWidgets('Ensure app setups correctly', (WidgetTester tester) async {
    await pumpMyApp(tester);

    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.text('Royal Stock Exchange'), findsOneWidget);
    expect(find.text('Trending News'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.search));

    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.text('Royal Stock Exchange'), findsNothing);
  });
}

Future<void> pumpMyApp(WidgetTester tester) async {
  await tester.pumpWidget(
    FutureBuilder<void>(
      future: Future.delayed(Duration.zero),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const SizedBox();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider(
            create: (_) => ThemeModel(),
            child: MultiBlocProvider(
              providers: [
                BlocProvider<NavBloc>.value(value: MockNavBloc()),
                BlocProvider<NewsBloc>.value(value: MockNewsBloc()),
                BlocProvider<AssetBloc>.value(value: MockAssetBloc()),
                BlocProvider<PortfolioBloc>.value(value: MockPortfolioBloc()),
              ],
              child: Builder(
                builder: (context) => MaterialApp.router(
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  routerConfig: goRouter,
                  debugShowCheckedModeBanner: false,
                  themeMode: Provider.of<ThemeModel>(context).isDarkMode
                      ? ThemeMode.dark
                      : ThemeMode.light,
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    ),
  );
}
