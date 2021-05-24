import 'package:flutter/material.dart';

class FluidNavBar extends StatelessWidget {
  static final double nominalWidth = 56;

  Function(int) onChange;

  FluidNavBar({Function(int) onChange}) {
    this.onChange = onChange;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: nominalWidth,
      color: Theme.of(context).secondaryHeaderColor,
      child: GestureDetector(
      //  onTap: onChange(0),
        child: Container(),
      ),
    );
  }
}
