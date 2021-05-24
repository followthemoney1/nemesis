import 'package:flutter/material.dart';
import 'package:sport_news/pr_extension.dart';

class GradientButton extends StatefulWidget {
  final String innerText;
  final double padding;
  const GradientButton({@required this.innerText, @required this.padding});

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation animation;

  Color beginColor;
  Color endColor;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 7),
      vsync: this,
    )..repeat(reverse: true);

    animation = ColorTween(begin: Color(0xFF9A03F6), end: Color(0xFF4851F1))
        .animate(_animationController)
          ..addListener(() {
            if (_animationController.isCompleted) {}
          });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Material(
                  type: MaterialType.card,
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.padding),
                  ),
                  color: (animation.value as Color),
                  child: Text(
                    widget.innerText,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontSize: 17, color: Colors.white),
                  ).paddingOnly(
                      left: widget.padding,
                      right: widget.padding,
                      top: widget.padding / 4,
                      bottom: widget.padding / 4)),
            ),
          );
        });
  }
}
