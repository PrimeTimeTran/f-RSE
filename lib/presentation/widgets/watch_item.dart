import 'package:flutter/material.dart';

import 'package:rse/data/all.dart';

class WatchItem extends StatefulWidget {
  final Watch item;

  const WatchItem(this.item, {Key? key}) : super(key: key);

  @override
  WatchItemState createState() => WatchItemState();
}

class WatchItemState extends State<WatchItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          String route = '/assets/${item.sym}';
          Navigator.pushNamed(context, route);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: isHovered ? Colors.black12 : Colors.transparent,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: Colors.white,
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
        ),
      ),
    );
  }
}
