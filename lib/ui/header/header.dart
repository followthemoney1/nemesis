import 'package:flutter/material.dart';

import '../../constants.dart';

class Header extends StatelessWidget {
  Widget child;
  Header({Widget child, Key key}) : super(key: key) {
    this.child = child;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(color: Theme.of(context).secondaryHeaderColor, child: header()),
      Flexible(
        child: Material(
          child: child,
        ),
      ),
    ]);
  }

  Widget header() {
    return Container(
      height: 20,
      width: double.infinity,
    );
  }
}
