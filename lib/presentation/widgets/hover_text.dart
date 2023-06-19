import 'package:flutter/material.dart';

class HoverText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;

  const HoverText(this.text, {super.key, this.textStyle});

  @override
  HoverTextState createState() => HoverTextState();
}

class HoverTextState extends State<HoverText> {
  Color textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(fontSize: 10, color: textColor);
    final mergedTextStyle = widget.textStyle != null
        ? defaultTextStyle.merge(widget.textStyle!)
        : defaultTextStyle;

    return MouseRegion(
      onHover: (event) {
        setState(() {
          textColor = Colors.red;
        });
      },
      onExit: (event) {
        setState(() {
          textColor = Colors.black;
        });
      },
      child: Text(
        widget.text,
        style: mergedTextStyle,
      ),
    );
  }
}