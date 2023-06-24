import 'package:flutter/material.dart';

class HoverDarken extends StatefulWidget {
  final Widget child;
  final bool padding;
  const HoverDarken({super.key, required this.child, this.padding = false});

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
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: isHovered ? Colors.black12 : Colors.transparent,
          ),
          child: Padding(
            padding: widget.padding ? const EdgeInsets.all(10.0) : const EdgeInsets.all(0),
            child: child
          ),
        ),
      ),
    );
  }
}

