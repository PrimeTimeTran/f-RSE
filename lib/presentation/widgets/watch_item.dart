import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:rse/data/all.dart';
import 'package:rse/presentation/all.dart';

class WatchItem extends StatefulWidget {
  final Watch item;

  const WatchItem(this.item, {Key? key}) : super(key: key);

  @override
  WatchItemState createState() => WatchItemState();
}

class WatchItemState extends State<WatchItem> {
  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return HoverDarken(
      child: GestureDetector(
        onTap: () {
          context.go("/${item.sym}");
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: T(context, 'outline'),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
