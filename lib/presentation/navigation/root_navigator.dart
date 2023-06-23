import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'package:rse/data/all.dart';
import 'package:rse/presentation/all.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('App'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {

    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  void _showModal(BuildContext context) {
    // get screen width
    double width = MediaQuery.of(context).size.width;
    // get screen height
    double height = MediaQuery.of(context).size.height;
    // String os = Platform.operatingSystem;
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            // Text('Operating System: $os'),
            Text('Screen Width: $width'),
            Text('Screen Height: $height'),
          ],
        );
      },
    );
  }
  void _handleLongPress (LongPressStartDetails details, context) {
    event();
    _showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Consumer<ThemeModel> (
            builder: (context, themeModel, _) {
              return GestureDetector(
                onDoubleTap: () {
                  event();
                  themeModel.toggleTheme();
                },
                onLongPressStart: (details) {
                  _handleLongPress(details, context);
                },
                child: const Text(
                  'Royal Stock Exchange',
                ),
              );
            },
          )
      ),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(label: 'Home', icon: Icon(Icons.home)),
          NavigationDestination(label: 'Investing', icon: Icon(Icons.candlestick_chart)),
          NavigationDestination(label: 'Notifications', icon: Icon(Icons.notifications)),
          NavigationDestination(label: 'Profile', icon: Icon(Icons.person)),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}

final goRouter = GoRouter(
  initialLocation: '/',
  // * Passing a navigatorKey causes an issue on hot reload:
  // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
  // * However it's still necessary otherwise the navigator pops back to
  // * root on hot reload
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
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
                path: '/',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeScreen(label: 'Home'),
                ),
                routes:
                watched.toList().map((e) => GoRoute(
                  path: e.sym,
                  builder: (context, state) => AssetScreen(sym: e.sym),
                )).toList()
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