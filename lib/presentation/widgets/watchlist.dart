import 'package:flutter/material.dart';

import 'package:rse/data/all.dart';
import 'package:rse/presentation/all.dart';

class Watchlist extends StatelessWidget {
  const Watchlist({
    super.key,
  });

  double getWatchlistWidth(context) {
    var width = MediaQuery.of(context).size.width;
    if (width > 767 && width < 825) {
      return width * .25;
    }
    return 400;
  }

  getMargin(context) {
    var width = MediaQuery.of(context).size.width;
    if (width > 767 && width < 825) {
      return EdgeInsets.fromLTRB(10, 0, 10, 0);
    }
    return EdgeInsets.fromLTRB(40, 0, 100, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .84,
        width: getWatchlistWidth(context),
        child: Container(
          margin: getMargin(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: T(context, 'outline'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: watched.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = watched[index];
                      return WatchItem(item);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
