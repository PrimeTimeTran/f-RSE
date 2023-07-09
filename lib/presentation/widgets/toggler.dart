import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Toggler extends StatefulWidget {
  final String type;
  final bool value;
  final ValueChanged onChanged;

  const Toggler({
    super.key,
    required this.type,
    required this.value,
    required this.onChanged,
  });

  @override
  TogglerState createState() => TogglerState();
}

class TogglerState extends State<Toggler> {
  @override
  Widget build(BuildContext context) {
    if (widget.type == 'theme') return _buildThemeToggler();
    return FlutterSwitch(
      value: widget.value,
      onToggle: (val) {
        setState(() {
          widget.onChanged(val);
        });
      },
    );
  }

  FlutterSwitch _buildThemeToggler() {
    return FlutterSwitch(
      padding: 2.0,
      width: 100.0,
      height: 55.0,
      toggleSize: 45.0,
      borderRadius: 30.0,
      value: widget.value,
      inactiveColor: Colors.white,
      activeColor: const Color(0xFF271052),
      activeToggleColor: const Color(0xFF6E40C9),
      inactiveToggleColor: const Color(0xFF2F363D),
      activeSwitchBorder: Border.all(
        width: 6.0,
        color: const Color(0xFF3C1E70),
      ),
      inactiveSwitchBorder: Border.all(
        width: 6.0,
        color: const Color(0xFFD1D5DA),
      ),
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
          widget.onChanged(1);
        });
      },
    );
  }
}
