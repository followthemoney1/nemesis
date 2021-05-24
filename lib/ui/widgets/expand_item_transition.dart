import 'dart:ui';

import 'package:flutter/material.dart';

class ExpandItemPageTransition extends StatelessWidget {
  const ExpandItemPageTransition({
    Key key,
    @required this.source,
    @required this.child,
  })  : assert(source != null),
        assert(child != null),
        super(key: key);

  final Rect source;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = ModalRoute.of(context).animation;
    final double topDisplayPadding = MediaQuery.of(context).padding.top;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Animation<double> positionAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.linearToEaseOut,
        );

        final Animation<RelativeRect> itemPosition = RelativeRectTween(
          begin: RelativeRect.fromLTRB(
              0, source.top, 0, constraints.biggest.height - source.bottom),
          end: RelativeRect.fill,
        ).animate(positionAnimation);

        final Animation<double> fadeMaterialBackground = CurvedAnimation(
          parent: animation,
          curve: const Interval(0.0, 0.3, curve: Curves.fastLinearToSlowEaseIn),
        );

        final double distanceToAvatar =
            topDisplayPadding + _calculateHeaderHeight(context) - 30;

        Animation<Offset> contentOffset = Tween<Offset>(
          begin: Offset(0, -distanceToAvatar),
          end: Offset.zero,
        ).animate(positionAnimation);

        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // ClipRect(
            //     child: BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            //   child: Container(color: Colors.white.withOpacity(0)),
            // )),
            PositionedTransition(
              rect: itemPosition,
              child: ClipRect(
                child: OverflowBox(
                  alignment: Alignment.center,
                  minHeight: constraints.maxHeight,
                  maxHeight: constraints.maxHeight,
                  child: AnimatedBuilder(
                    animation: contentOffset,
                    child: FadeTransition(
                      opacity: fadeMaterialBackground,
                      child: Material(
                        type: MaterialType.transparency,
                        child: child,
                      ),
                    ),
                    builder: (BuildContext context, Widget child) {
                      return Transform.translate(
                        offset: contentOffset.value,
                        child: child,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  double _calculateHeaderHeight(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width -
        80; // Padding on both sides and arrow button
    final TextSpan span = TextSpan(style: Theme.of(context).textTheme.display1);
    final TextPainter painter =
        TextPainter(text: span, textDirection: TextDirection.ltr);
    painter.layout(minWidth: 0, maxWidth: maxWidth);
    return painter.height;
  }
}
