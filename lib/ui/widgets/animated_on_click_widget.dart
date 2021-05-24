//MARK: supportive classes
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

@immutable
// ignore: must_be_immutable
class AnimatedWidgetOnClick extends StatefulWidget {
  Widget child;
  Function onTap;
  int animation_miliseconds;

  AnimatedWidgetOnClick(
      {@required this.child,
      @required this.onTap,
      this.animation_miliseconds = 100});

  @override
  _AnimatedWidgetOnClickState createState() => _AnimatedWidgetOnClickState();
}

class _AnimatedWidgetOnClickState extends State<AnimatedWidgetOnClick>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.animation_miliseconds),
      lowerBound: 0.0,
      upperBound: 0.1,
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTap() {
    if (widget.onTap != null) _playAnimation();
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
      widget.onTap();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

//    return GestureDetector(
////      behavior: HitTestBehavior.opaque,
//      onTap: _onTap,
////      onTapDown: _onTapDown,
////      onTapUp: _onTapUp,
//      child: Transform.scale(
//        scale: _scale,
//        child: widget.child,
//      ),
//    );

    return RawGestureDetector(
      gestures: {
        AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<
            AllowMultipleGestureRecognizer>(
          () => AllowMultipleGestureRecognizer(),
          (AllowMultipleGestureRecognizer instance) {
            instance
              ..onTap = () async {
                _onTap();
              };
          },
        )
      },
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}

class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
