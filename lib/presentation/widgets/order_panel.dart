import 'package:flutter/material.dart';

import 'package:rse/all.dart';

class OrderPanel extends StatefulWidget {
  const OrderPanel({super.key});

  @override
  State<OrderPanel> createState() => OrderPanelState();
}

class OrderPanelState extends State<OrderPanel> {
  @override
  Widget build(BuildContext context) {
    final color = T(context, 'primary');
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Container(
            color: T(context, 'secondaryContainer'),
            child: DefaultTabController(
              length: 2,
              animationDuration: const Duration(milliseconds: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: TabBar(
                      labelColor: color,
                      indicatorColor: color,
                      unselectedLabelColor: Theme.of(context).indicatorColor,
                      tabs: const [
                        SizedBox(
                          width: 30,
                          child: Tab(text: 'Buy'),
                        ),
                        SizedBox(
                          width: 30,
                          child: Tab(text: 'Sell'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                          child: Column(
                            children: [
                              const Expanded(
                                child: Row(
                                  children: [
                                    Text('Order Type'),
                                    Spacer(),
                                    Text('0.00000000'),
                                  ],
                                ),
                              ),
                              const Expanded(
                                child: Row(
                                  children: [
                                    Text('Buy In'),
                                    Spacer(),
                                    Text('0.00000000'),
                                  ],
                                ),
                              ),
                              const Expanded(
                                child: Row(
                                  children: [
                                    Text('Shares'),
                                    Spacer(),
                                    Text('0.00000000'),
                                  ],
                                ),
                              ),
                              const Expanded(
                                child: Row(
                                  children: [
                                    Text('Market Price'),
                                    Spacer(),
                                    Text('0.00000000'),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                height: 1,
                                color: Colors.grey[300],
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text('Estimated Cost'),
                                    Spacer(),
                                    Text('0.00000000'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    backgroundColor: color,
                                    minimumSize: const Size(double.infinity, 50),
                                  ),
                                  child: const Text('Review Order'),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                height: 1,
                                color: Colors.grey[300],
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Buying Power \$100,000'),
                                ],
                              ),
                            ]
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                          child: Column(
                              children: [
                                const Expanded(
                                  child: Row(
                                    children: [
                                      Text('Order Type'),
                                      Spacer(),
                                      Text('0.00000000'),
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  child: Row(
                                    children: [
                                      Text('Sell In'),
                                      Spacer(),
                                      Text('0.00000000'),
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  child: Row(
                                    children: [
                                      Text('Shares'),
                                      Spacer(),
                                      Text('0.00000000'),
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  child: Row(
                                    children: [
                                      Text('Market Price'),
                                      Spacer(),
                                      Text('0.00000000'),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  height: 1,
                                  color: Colors.grey[300],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text('Estimated Credit'),
                                      Spacer(),
                                      Text('0.00000000'),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      backgroundColor: color,
                                      minimumSize: const Size(double.infinity, 50),
                                    ),
                                    child: const Text('Review Order'),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  height: 1,
                                  color: Colors.grey[300],
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Buying Power \$100,000'),
                                  ],
                                ),
                              ]
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
      ],
    );
  }
}
