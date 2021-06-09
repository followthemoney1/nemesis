import 'package:flutter/material.dart';

class MousePosition extends StatelessWidget {
  Widget child;
  Function(PointerEvent)? onEnter;
  Function(PointerEvent)? onExit;
  Function(PointerEvent)? onHover;

  MousePosition({required this.child, this.onEnter, this.onExit, this.onHover});

  void _incrementEnter(PointerEvent details) {
    if (onEnter != null) onEnter!(details);
  }

  void _incrementExit(PointerEvent details) {
    if (onExit != null) onExit!(details);
  }

  void _updateLocation(PointerEvent details) {
    if (onHover != null) onHover!(details);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(const Size(300.0, 200.0)),
      child: MouseRegion(
          onEnter: _incrementEnter,
          onHover: _updateLocation,
          onExit: _incrementExit,
          child: child),
    );
  }
}
