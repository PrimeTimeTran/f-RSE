import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:rse/all.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class App extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const App({super.key, required this.navigationShell});

  @override
  State<App> createState() => _AppState();
}

final MyNavigatorObserver observer = MyNavigatorObserver(
  onPushStack: (int i) {},
);

class _AppState extends State<App> {
  bool home = true;
  String header = 'Royal Stock Exchange';

  void onPushStack(int idx) {
    setState(() {
      home = !home;
    });
  }

  setHeader(String header) {
    setState(() {
      this.header = header;
    });
  }

  @override
  void initState() {
    super.initState();
    observer.onPushStack = onPushStack;
    _shellNavigatorAKey.currentState?.widget.observers.add(observer);
    logAppLoadSuccess();
  }

  resetStack(int idx) {
    widget.navigationShell.goBranch(
      idx,
      initialLocation: idx == widget.navigationShell.currentIndex,
    );
  }

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
              icon: Icon(home ? Icons.menu : Icons.arrow_back),
              onPressed: () {
                if (home) {
                  Scaffold.of(context).openDrawer();
                } else {
                  resetStack(0);
                }
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
              child: Text(
                home ? 'Royal Stock Exchange' : 'Security',
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        resetStack: resetStack,
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
      if (bloc.portfolio.meta != null
          ? bloc.portfolio.meta!.totalValue != 0
          : false) {
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
          observers: [observer, fbAnalyticsObserver],
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeScreen(label: 'Home'),
              ),
            ),
            GoRoute(
              path: '/securities/:sym',
              builder: (context, state) => AssetScreen(sym: state.pathParameters['sym']!),
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
              path: '/profile',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ProfileScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

Future<String> getVersionId() async {
  try {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    return '$version $buildNumber';
  } on Exception catch (_) {
    return '';
  }
}

void _showModal(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  bool showAppConfig = remoteConfig.getValue('app_show_config').asBool();
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          Text('Screen Width: ${width.toStringAsFixed(2)}'),
          Text('Screen Height: ${height.toStringAsFixed(2)}'),
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
          if (showAppConfig)
            FutureBuilder<String>(
              future: getVersionId(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(snapshot.data ?? '');
                }
              },
            ),
          FutureBuilder<String>(
            future: getVersionId(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(remoteConfig.getValue('app_secret').asString() ?? '');
              }
            },
          ),
        ],
      );
    },
  );
}

void _handleLongPress(LongPressStartDetails details, context) {
  _showModal(context);
}
