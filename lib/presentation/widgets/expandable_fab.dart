import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:rse/all.dart';

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final double distance;
  final bool? initialOpen;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      vsync: this,
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomRight,
        children: [
          _buildTapToCloseFab(context),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(context  ),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab(context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          elevation: 4,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.close,
                color: T(context, 'primary'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
    i < count;
    i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          child: widget.children[i],
          progress: _expandAnimation,
          maxDistance: widget.distance,
          directionInDegrees: angleInDegrees,
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab(context) {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 250),
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          child: FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: T(context, 'onPrimaryContainer'),
            child: Icon(
              Icons.create,
              color: T(context, 'primary')
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.child,
    required this.progress,
    required this.maxDistance,
    required this.directionInDegrees,
  });

  final Widget child;
  final double maxDistance;
  final Animation<double> progress;
  final double directionInDegrees;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.title,
  });

  final Widget icon;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = T(context, 'background');
    return Material(
      elevation: 4,
      shape: const CircleBorder(),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: theme,
          shape: const CircleBorder(),
          minimumSize: const Size(56, 56),
          padding: const EdgeInsets.all(16),
        ),
        child: Text(title),
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    super.key,
    required this.isBig,
  });

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isBig ? 128 : 36,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
    );
  }
}