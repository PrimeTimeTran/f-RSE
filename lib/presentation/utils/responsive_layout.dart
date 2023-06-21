import 'package:flutter/material.dart';

import 'package:rse/presentation/all.dart';

const mobileWidth = 600;

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveLayout({super.key, required this.mobile, required this.desktop});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileWidth) {
          return mobile;
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: desktop
          );
        }
      },
    );
  }
}
