import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/all.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class App extends StatefulWidget {
  final StatefulNavigationShell shell;

  const App({super.key, required this.shell});

  @override
  State<App> createState() => _AppState();
}

// A drawer wraps a bottom tab bar wraps nested stacks:

// - Drawer:
//   - Hamburger menu icon in app bar leading of all root bottom tab screens.
//   - Hamburger icon press opens drawer.
// - Bottom Tab:
//   - Contains stacks in each tab.
//   - Push replaces hamburger icon with back arrow icon.
//   - Back arrow icon press pops stack to previous screen.
//   - Popping from stack replaces back arrow with hamburger icon when root reached.
//   - Bottom tab icon press when already on this tab resets the stack to root screen of the stack.
//   - State should be preserved between stacks:
//      - Leaving tab and returning should maintain scroll position.
//      - Navigate to 2nd screen of home, asset.
//      - Press 2nd tab, investing.
//      - Press 1st tab, home.
//      - 1st tab 2nd screen, asset, should still be present.

// https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/

// https://github.com/flutter/flutter/issues/112196
// The messy code from this navigation comes from goRouter lack
// of API for observers working correctly within nested navigators.
// We can't easily know when a nested Stack is pushed or popped.
// So we have to manually track it in order to know when to show/hide the appbar.

// If we don't do this, the appbar will be shown when the user navigates to nested stacks.
// We have to manually hide it when the user navigates to a nested stack.

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    logAppLoadSuccess();
  }

  resetStack(int tabIdx) {
    final shell = widget.shell;
    if (tabIdx == shell.currentIndex) {
      BlocProvider.of<NavBloc>(context).add(NavChanged('$tabIdx-0'));
    }

    shell.goBranch(
      tabIdx,
      initialLocation: tabIdx == shell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavBloc, NavState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          body: widget.shell,
          drawer: const MyDrawer(),
          appBar: tabRootAppBar(state.states[widget.shell.currentIndex]),
          bottomNavigationBar: BottomNavBar(
            shell: widget.shell,
            resetStack: resetStack,
          ),
        );
      },
    );
  }

  PreferredSize? tabRootAppBar(int tabStackIdx) {
    return tabStackIdx == 0
        ? PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBarWithSearch(
              tabIndex: widget.shell.currentIndex,
            ),
          )
        : null;
  }
}

final goRouter = GoRouter(
  initialLocation: '/',
  // * Passing a navigatorKey causes an issue on hot reload:
  // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
  // * However it's still necessary otherwise the navigator pops back to
  // * root on hot reload
  // debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  observers: [],
  redirect: (context, state) {
    String location = state.location;
    if (location == '/') {
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
      builder: (context, state, shell) {
        return App(shell: shell);
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
              routes: [
                GoRoute(
                  path: 'securities/:sym',
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: AssetScreen(sym: state.pathParameters['sym']!),
                  ),
                ),
              ],
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
              routes: [
                GoRoute(
                  path: 'settings',
                  pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey,
                    child: const ProfileSettingsScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
