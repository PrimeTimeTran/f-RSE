import 'package:flutter/material.dart';

import 'package:rse/presentation/all.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveLayout({super.key, required this.mobile, required this.desktop});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isS(context)) {
          return Container(
            // color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: mobile,
            ),
          );
        } else if (isM(context)){
          return Container(
            // color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: desktop
            ),
          );
        } else if (isL(context)) {
          return Container(
            // color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: desktop
            ),
          );
        } else {
          return Container(
            // color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 10),
              child: desktop
            ),
          );
        }
      },
    );
  }
}
