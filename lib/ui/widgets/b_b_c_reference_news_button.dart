import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sport_news/pr_extension.dart';

class BBCReferenceNewsButton extends StatefulWidget {
  String innerText;
  double padding;
  BBCReferenceNewsButton({@required this.innerText, @required this.padding});

  @override
  _BBCReferenceNewsButtonState createState() => _BBCReferenceNewsButtonState();
}

class _BBCReferenceNewsButtonState extends State<BBCReferenceNewsButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation mainAnimationColor;
  Animation firstAnimation;
  Animation secondAnimation;
  Animation thirdAnimation;

  ColorTween _colorTween;
  Animation<Color> _colorTweenAnimation;
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
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..repeat(reverse: true);

    firstAnimation =
        ColorTween(begin: Color(0xFFFFCC00), end: Color(0xFFFF9500))
            .animate(_animationController)
              ..addListener(() {
                if (_animationController.isCompleted) {
                  setState(() {
                    mainAnimationColor = secondAnimation;
                  });
                }
              });
    secondAnimation =
        ColorTween(begin: Color(0xFFFF9500), end: Color(0xFFFFAF11))
            .animate(_animationController)
              ..addListener(() {
                if (_animationController.isCompleted) {
                  setState(() {
                    mainAnimationColor = thirdAnimation;
                  });
                }
              });

    thirdAnimation = ColorTween(begin: Color(0xFFFFAF11), end: Colors.orange)
        .animate(_animationController)
          ..addListener(() {
            if (_animationController.isCompleted) {
              setState(() {
                mainAnimationColor = firstAnimation;
              });
            }
          });

    mainAnimationColor = firstAnimation;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'BBC_NEWS_HERO',
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              width: widget.padding,
              height: widget.padding / 2.5,
              child: Material(
                  type: MaterialType.card,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(widget.padding)),
                      side: BorderSide(
                          width: 2,
                          color: (mainAnimationColor.value as Color))),
                  borderOnForeground: true,
                  color: Colors.transparent,
                  child: Center(
                    child: AutoSizeText(
                      widget.innerText,
                      maxLines: 2,
                      maxFontSize: 14,
                      minFontSize: 6,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w600),
                    ).paddingOnly(left: 6, right: 6),
                  )),
            );
          }),
    );
  }
}
