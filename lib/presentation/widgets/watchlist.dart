import 'package:flutter/material.dart';

import 'package:rse/data/all.dart';
import 'package:rse/presentation/all.dart';

class Watchlist extends StatelessWidget {
  const Watchlist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .77,
        width: MediaQuery.of(context).size.width * 0.25,
        child: Container(
          margin: const EdgeInsets.fromLTRB(40, 0, 100, 0),
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
