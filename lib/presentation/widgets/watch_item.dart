import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:rse/all.dart';

class WatchItem extends StatefulWidget {
  final Watch item;

  const WatchItem(this.item, {Key? key}) : super(key: key);

  @override
  WatchItemState createState() => WatchItemState();
}

getPadding(context) {
  if (isS(context)) {
    return const EdgeInsets.all(1.0);
  } else if (isM(context)){
    return const EdgeInsets.symmetric(horizontal: 5, vertical: 5);
  } else if (isL(context)) {
    return const EdgeInsets.symmetric(horizontal: 10, vertical: 5);
  } else {
    return const EdgeInsets.symmetric(horizontal: 20, vertical: 5);
  }
}

getHeight(context) {
  if (isS(context)) {
    return 100.0;
  } else if (isM(context)){
    return 90.0;
  } else if (isL(context)) {
    return 100.0;
  } else {
    return 100.0;
  }
}

class WatchItemState extends State<WatchItem> {
  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return HoverDarken(
      child: GestureDetector(
        onTap: () {
          context.go("/securities/${item.sym}");
        },
        child: Container(
          height: getHeight(context),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: T(context, 'outline'),
              ),
            ),
          ),
          child: Padding(
            padding: getPadding(context),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.sym,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        item.shares.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('CHART'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.price.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        item.change.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
