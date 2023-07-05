import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:rse/all.dart';

class AppBarWithSearch extends StatefulWidget {
  final int tabIndex;

  const AppBarWithSearch({super.key, required this.tabIndex});

  @override
  State<AppBarWithSearch> createState() => _AppBarWithSearchState();
}

class _AppBarWithSearchState extends State<AppBarWithSearch> {
  bool _isSearching = false;
  late FocusNode myFocusNode;
  String searchQuery = "Search query";
  final TextEditingController _searchQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    navigate() => context.go('/profile/settings');
    return AppBar(
      leading: _buildLeading(),
      title: _buildTitle(context),
      actions: _buildActions(context, navigate),
    );
  }

  _buildLeading() {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }

  _buildTitle(context) {
    return _isSearching ? _buildSearchField() : _buildTitleHelper(context);
  }

  Widget _buildSearchField() {
    return TextField(
      focusNode: myFocusNode,
      controller: _searchQueryController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "Search Assets...",
        border: InputBorder.none,
        hintStyle: TextStyle(),
      ),
      style: const TextStyle(fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  _buildTitleHelper(context) {
    return Consumer<ThemeModel>(
      builder: (context, themeModel, _) {
        return GestureDetector(
          onDoubleTap: themeModel.toggleTheme,
          onLongPressStart: (details) {
            _handleLongPress(details, context);
          },
          child: const Text('Royal Stock Exchange'),
        );
      },
    );
  }

  List<Widget> _buildActions(context, navigate) {
    if (widget.tabIndex == 3) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            BlocProvider.of<NavBloc>(context).add(NavChanged('3-1'));
            navigate();
          },
        ),
      ];
    }

    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          myFocusNode.requestFocus();
          _startSearch();
        },
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}

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
                return Text(
                    remoteConfig.getValue('app_secret').asString());
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
