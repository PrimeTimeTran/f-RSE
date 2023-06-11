import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final List<Ticker> tickers;

  const Carousel({super.key, required this.tickers});

  @override
  CarouselState createState() =>
      CarouselState();
}

class CarouselState
    extends State<Carousel>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animation;
  late AnimationController _animationController;
  late GlobalKey _tickerBarKey; // Added GlobalKey declaration

  @override
  void initState() {
    super.initState();
    _tickerBarKey = GlobalKey(); // Initialize GlobalKey
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final widgetWidth = _tickerBarKey.currentContext?.size?.width ?? 0.0;
        final screenWidth = MediaQuery.of(context).size.width;
        final offsetX = screenWidth / widgetWidth;

        _animation = Tween<Offset>(
          begin: Offset(offsetX, 0.0),
          end: const Offset(-1.0, 0.0),
        ).animate(CurvedAnimation(
          curve: Curves.linear,
          parent: _animationController,
        ));
        _animationController.reset();
        _animationController.forward();
      }
    });

    _animation = Tween<Offset>(
      end: const Offset(-1.0, 0.0),
      begin: const Offset(0, 0),
    ).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: _animationController,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ClipRect(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget? child) {
              return SlideTransition(
                position: _animation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    key: _tickerBarKey,
                    children: widget.tickers.map((ticker) {
                      MaterialColor color = getIndicationColor(ticker);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              ticker.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  getArrow(ticker),
                                  size: 16.0,
                                  color: color,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  ticker.pointsUpDown.toStringAsFixed(2),
                                  style: TextStyle(
                                    color: color,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '(${ticker.percentage.toStringAsFixed(2)}%)',
                                  style: TextStyle(
                                    color: color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  IconData getArrow(Ticker t) {
    return t.pointsUpDown >= 0 ? Icons.arrow_upward : Icons.arrow_downward;
  }

  MaterialColor getIndicationColor(Ticker t) {
    return t.pointsUpDown >= 0 ? Colors.green : Colors.red;
  }
}


class TickerCarousel extends StatefulWidget {
  const TickerCarousel({super.key});

  @override
  TickerCarouselState createState() => TickerCarouselState();
}

class TickerCarouselState extends State<TickerCarousel> {
  final List<Ticker> tickers = [
    Ticker('WMT', 152.51, 1.32, 0.87),
    Ticker('AMZN', 3311.37, 11.61, 0.35),
    Ticker('XOM', 280.48, -0.29, -0.10),
    Ticker('BRK.A', 152.51, 1.32, 0.87),
    Ticker('AAPL', 3311.37, 11.61, 0.35),
    Ticker('UNH', 280.48, -0.29, -0.10),
    Ticker('MCK', 152.51, 1.32, 0.87),
    Ticker('CVS', 3311.37, 11.61, 0.35),
    Ticker('ABC', 280.48, -0.29, -0.10),
    Ticker('AMZN', 152.51, 1.32, 0.87),
    Ticker('GM', 3311.37, 11.61, 0.35),
    Ticker('MSFT', 280.48, -0.29, -0.10),
    Ticker('GOOGL', 2647.23, 12.51, 0.47),
    Ticker('JPM', 156.78, -1.29, -0.82),
    Ticker('T', 27.84, 0.09, 0.32),
    Ticker('DIS', 174.32, -0.91, -0.52),
    Ticker('CSCO', 52.79, 0.56, 1.07),
    Ticker('VZ', 56.15, 0.12, 0.21),
    Ticker('BAC', 40.89, -0.78, -1.87),
    Ticker('NFLX', 484.58, 7.12, 1.49),
    Ticker('PG', 135.68, -0.19, -0.14),
    Ticker('UPS', 194.25, -0.92, -0.47),
    Ticker('GE', 99.45, 0.16, 0.16),
  ];

  @override
  Widget build(BuildContext context) {
    return Carousel(tickers: tickers);
  }
}

class Ticker {
  final String name;
  final double price;
  final double pointsUpDown;
  final double percentage;

  Ticker(this.name, this.price, this.pointsUpDown, this.percentage);
}
