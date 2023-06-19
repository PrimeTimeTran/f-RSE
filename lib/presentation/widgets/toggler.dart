import 'package:flutter/material.dart';

class Toggler extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const Toggler({super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  TogglerState createState() => TogglerState();
}

class TogglerState extends State<Toggler> {
  late bool _isToggled;

  @override
  void initState() {
    super.initState();
    _isToggled = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isToggled,
      onChanged: (newValue) {
        setState(() {
          _isToggled = newValue;
        });
        widget.onChanged(newValue);
      },
    );
  }
}