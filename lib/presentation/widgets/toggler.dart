import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Toggler extends StatefulWidget {
  final bool initialValue;
  final ValueChanged onChanged;

  const Toggler({
    super.key,
    required this.onChanged,
    required this.initialValue,
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
    return FlutterSwitch(
      width: 100.0,
      height: 55.0,
      toggleSize: 45.0,
      value: _isToggled,
      borderRadius: 30.0,
      padding: 2.0,
      activeToggleColor: const Color(0xFF6E40C9),
      inactiveToggleColor: const Color(0xFF2F363D),
      activeSwitchBorder: Border.all(
        color: const Color(0xFF3C1E70),
        width: 6.0,
      ),
      inactiveSwitchBorder: Border.all(
        color: const Color(0xFFD1D5DA),
        width: 6.0,
      ),
      activeColor: const Color(0xFF271052),
      inactiveColor: Colors.white,
      activeIcon: const Icon(
        Icons.nightlight_round,
        color: Color(0xFFF8E3A1),
      ),
      inactiveIcon: const Icon(
        Icons.wb_sunny,
        color: Color(0xFFFFDF5D),
      ),
      onToggle: (val) {
        setState(() {
          _isToggled = val;
          widget.onChanged(1);
        });
      },
    );
  }
}
