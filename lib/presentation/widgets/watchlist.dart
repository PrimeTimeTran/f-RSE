import 'package:flutter/material.dart';

import 'package:rse/all.dart';

class Watchlist extends StatelessWidget {
  const Watchlist({
    super.key,
  });

  getWidth(context) {
    var width = MediaQuery.of(context).size.width;
    if (isS(context)) {
      return width * .1;
    } else if (isM(context)) {
      return width * .3;
    } else if (isL(context)) {
      return width * .3;
    } else {
      return width * .2;
    }
  }

  getMargin(context) {
    if (isS(context)) {
      return const EdgeInsets.all(5);
    } else if (isM(context)) {
      return const EdgeInsets.all(5);
    } else if (isL(context)) {
      return const EdgeInsets.all(30);
    } else {
      return const EdgeInsets.all(40);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: getWidth(context),
        height: MediaQuery.of(context).size.height,
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
