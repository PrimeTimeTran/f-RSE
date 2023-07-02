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
    return const Column(
      children: [
        SizedBox(height: 20),
        Text('Order Panel'),
        SizedBox(height: 20),
      ],
    );
  }
}
