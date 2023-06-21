import 'package:flutter/material.dart';

class HoverDarken extends StatefulWidget {
  final Widget child;
  const HoverDarken({super.key, required this.child});

  @override
  State<HoverDarken> createState() => _HoverDarkenState();
}

class _HoverDarkenState extends State<HoverDarken> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final child = widget.child;
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
          // context.go("/${item.sym}");
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), // Set the border radius here
            color: isHovered ? Colors.black12 : Colors.transparent,
          ),
          child: child,
        ),
      ),
    );
  }
}

