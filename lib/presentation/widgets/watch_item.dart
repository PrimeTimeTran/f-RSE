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

    final item = widget.item;
    if (isS(context)) {
      return buildSmall(context, navigate);
    }
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }

  Widget buildSmallChart(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(2010, 35),
      ChartData(2011, 28),
      ChartData(2012, 34),
      ChartData(2013, 32),
      ChartData(2014, 40)
    ];
    return SizedBox(
      height: 70,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        child: SfCartesianChart(
          primaryYAxis: NumericAxis(
            isVisible: false,
          ),
          primaryXAxis: NumericAxis(
            isVisible: false,
          ),
          plotAreaBorderWidth: 0,
          borderColor: Colors.transparent,
          series: <ChartSeries>[
            LineSeries<ChartData, int>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSmall(context, navigate) {
    final item = widget.item;
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
                  buildSmallChart(context),
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
                        getColor(item),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                          color: getColor(item),
                        ),
                      ),
                    ),
                    child: Text(item.price.toString()),
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