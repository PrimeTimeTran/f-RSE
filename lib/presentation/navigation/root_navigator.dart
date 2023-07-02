import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/rendering.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'package:rse/all.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//Make this widget a stateful widget

class App extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  App({super.key, required this.navigationShell});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: widget.navigationShell,
      drawer: const MyDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Consumer<ThemeModel>(
          builder: (context, themeModel, _) {
            return GestureDetector(
              onDoubleTap: themeModel.toggleTheme,
              onLongPressStart: (details) {
                _handleLongPress(details, context);
              },
              child: const Text(
                'Royal Stock Exchange',
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        navigationShell: widget.navigationShell,
      ),
    );
  }
}

final goRouter = GoRouter(
  initialLocation: '/home',
  // * Passing a navigatorKey causes an issue on hot reload:
  // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
  // * However it's still necessary otherwise the navigator pops back to
  // * root on hot reload
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  redirect: (context, state) {
    String location = state.location;
    if (location == '/home') {
      final bloc = context.read<PortfolioBloc>();
      bloc.fetchPortfolio(1);
      if (bloc.portfolio.current.totalValue != 0) {
        context.read<ChartBloc>().updateChartPortfolioValues(bloc.portfolio);
      }
    }
    if (location.startsWith('/securities/')) {
      final bloc = context.read<AssetBloc>();
      final sym = location.substring(12);
      bloc.fetchAsset(sym);
    }
    return state.location;
  },
  routes: [
    // Stateful navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return App(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeScreen(label: 'Home'),
              ),
            ),
            GoRoute(
              path: '/securities/:sym',
              builder: (context, state) => const AssetScreen(sym: ''),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              path: '/investing',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const InvestingSummaryScreen(title: 'osos'),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            GoRoute(
              path: '/notifications',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const NotificationsScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDKey,
          routes: [
            GoRoute(
              path: '/spending',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const AssetScreen(sym: 'BAC'),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

void _showModal(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          Text('Screen Width: $width'),
          Text('Screen Height: $height'),
          TextButton(
            onPressed: () => throw Exception(),
            child: const Text("Throw Test Exception"),
          ),
          TextButton(
            onPressed: () {
              final bool value = debugPaintSizeEnabled;
              debugPaintSizeEnabled = !value;
            },
            child: const Text("Enable Debug Paint Size"),
          ),
        ],
      );
    },
  );
}

void _handleLongPress(LongPressStartDetails details, context) {
  _showModal(context);
}