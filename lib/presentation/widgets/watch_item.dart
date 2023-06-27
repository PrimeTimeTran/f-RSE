import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:rse/all.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WatchItem extends StatefulWidget {
  final Watch item;

  const WatchItem(this.item, {Key? key}) : super(key: key);

  @override
  WatchItemState createState() => WatchItemState();
}

class WatchItemState extends State<WatchItem> {
  @override
  Widget build(BuildContext context) {
    // Context when passed to buildSmall is not the same as the context
    // So we define the navigate here and pass it to the button.
    navigate() {
      context.go("/securities/${widget.item.sym}");
    }

    if (isS(context)) {
      return buildSmall(context, navigate);
    }
    final List<ChartData> data = [
      ChartData(2010, randomInt(20, 40)),
      ChartData(2011, randomInt(20, 40)),
      ChartData(2012, randomInt(20, 40)),
      ChartData(2013, randomInt(20, 40)),
      ChartData(2014, randomInt(20, 40))
    ];

    final item = widget.item;
    final color = data.first.y < data.last.y ? Colors.green : Colors.red;
    return HoverDarken(
      radius: false,
      padding: false,
      child: GestureDetector(
        onTap: () {
          navigate();
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
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                Expanded(
                  flex: 2,
                  child: buildSmallChart(context, color, data, true)
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        formatMoney(item.price.toString()),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formatMoney(item.change),
                        style: TextStyle(
                          fontSize: 10,
                          color: color,
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
    );
  }

  Widget buildSmallChart(BuildContext context, color, data, large) {
    return IgnorePointer(
      child: SizedBox(
        height: large ? 100 : 70,
        width: large ? 250 : 100,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            borderColor: Colors.transparent,
            primaryXAxis: NumericAxis(
              isVisible: false,
            ),
            primaryYAxis: NumericAxis(
              isVisible: false,
              majorGridLines: const MajorGridLines(
                width: 2,
                dashArray: <double>[4, 3],
              ),
              plotBands: [
                PlotBand(
                  opacity: 0.5,
                  borderWidth: 1,
                  end: data.last.y,
                  start: data.last.y,
                  dashArray: const [4, 3],
                  borderColor: T(context, 'inversePrimary'),
                ),
              ],
            ),
            series: <ChartSeries>[
              LineSeries<ChartData, int>(
                dataSource: data,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                color: color
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSmall(context, navigate) {
    final List<ChartData> data = [
      ChartData(2010, randomInt(20, 40)),
      ChartData(2011, randomInt(20, 40)),
      ChartData(2012, randomInt(20, 40)),
      ChartData(2013, randomInt(20, 40)),
      ChartData(2014, randomInt(20, 40))
    ];

    final item = widget.item;
    final color = data.first.y < data.last.y ? Colors.green : Colors.red;
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      item.sym,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    item.shares.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildSmallChart(context, color, data, false),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      navigate();
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size(100, 35),
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        color,
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                          color: color,
                        ),
                      ),
                    ),
                    child: Text(formatMoney(item.price.toString())),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final int x;
  final int y;
}

getPadding(context) {
  if (isS(context)) {
    return const EdgeInsets.all(1.0);
  } else if (isM(context)) {
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
  } else if (isM(context)) {
    return 90.0;
  } else if (isL(context)) {
    return 100.0;
  } else {
    return 100.0;
  }
}

MaterialColor getColor(Watch item) {
  return item.changePercent > 0 ? Colors.green : Colors.red;
}