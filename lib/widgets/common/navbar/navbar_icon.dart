import 'package:flutter/material.dart';
import 'package:sprung/sprung.dart';

class NavbarIconWidget extends StatefulWidget {
  const NavbarIconWidget({
    super.key,
    required this.RotateDirection,
    required this.svg,
  });

  final String RotateDirection;
  final Widget svg;

  @override
  State<NavbarIconWidget> createState() => _NavbarIconWidgetState();
}

class _NavbarIconWidgetState extends State<NavbarIconWidget> {
  double turns = 0.0;
  bool isSelected = false;

  void _moveUp() {
    setState(() {
      isSelected = true;
    });
  }

  void _rotate() {
    setState(() {
      widget.RotateDirection == 'right' ? turns += 6 / 360 : turns -= 6 / 360;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _moveUp();
      _rotate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        height: 37,
        curve: Sprung.underDamped,
        alignment: isSelected ? Alignment.topCenter : Alignment.bottomCenter,
        duration: const Duration(milliseconds: 600),
        child: AnimatedRotation(
            turns: turns,
            curve: Sprung.criticallyDamped,
            duration: const Duration(milliseconds: 600),
            child: widget.svg));
  }
}
