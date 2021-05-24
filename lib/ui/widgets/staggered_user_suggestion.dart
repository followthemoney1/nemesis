import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:sport_news/data/network/categories.dart';
import 'package:sport_news/pr_extension.dart';
import 'package:sport_news/style/theme/gallery_theme_data.dart';
import 'package:sport_news/ui/widgets/visibility.dart';

import '../../constants.dart';

class SuggestionItem {
  FirebaseCategories data;
  String name;
  int currentWeight = 1;
  double width;
  double height;
  double x;
  double y;
  int iRow;
  int iColumn;
  String image;
  String icon;
  get selected => currentWeight > 1;
  get superLike => currentWeight == 3;
  get leftTop => x + y;
  get rightTop => y + x + width;
  get leftBottom => x + y + height;
  get rightBottom => leftTop + width + height;

  get left => x;
  get right => x + width;
  get bottom => y + height;
  get top => y;

  get isExpanded => currentWeight > 1;

  get color => Colors.black;
  Rect get rect => Rect.fromLTWH(left, top, width, height);

  SuggestionItem({
    this.data,
    this.name,
    this.image,
    this.icon,
    this.width,
    this.height,
    this.currentWeight,
    this.x,
    this.y,
  });
}

class CardItemWidget extends StatefulWidget {
  final Color backgroundColor;
  final IconData iconData;
  final int weight;
  final double width;
  final double height;
  final String name;
  final SuggestionItem el;
  final String localImage;
  const CardItemWidget(
      {this.backgroundColor,
      this.iconData,
      this.weight = 1,
      this.width,
      this.height,
      this.name,
      this.localImage,
      this.el});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CardItemWidgetState();
  }
}

class CardItemWidgetState extends State<CardItemWidget>
    with TickerProviderStateMixin {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xFF9B51E0), Color(0xff5D3DF3)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 100.0, 70.0));

  @override
  Widget build(BuildContext context) {
    final unselectedStyle = Theme.of(context).textTheme.headline5.copyWith(
        color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold);

    final selectedStyle = Theme.of(context).textTheme.headline5.copyWith(
        foreground: (Paint()..shader = linearGradient),
        fontSize: 18,
        fontWeight: FontWeight.bold);
    final selected = widget.el.selected;
    final superLike = widget.el.superLike;

    return Stack(children: [
      Container(
        child: Card(
          elevation: 6,
          shape: selected
              ? new RoundedRectangleBorder(
                  side: new BorderSide(
                      color: Color(0xFF9B51E0).withOpacity(0.6), width: 1),
                  borderRadius: BorderRadius.circular(14))
              : new RoundedRectangleBorder(
                  side: new BorderSide(
                      color: Colors.white.withOpacity(0.2), width: 0.3),
                  borderRadius: BorderRadius.circular(14)),
          color: NewsThemeData.buttonMainColor,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  child: widget.localImage == null
                      ? ExtendedImage.network(
                          widget.el.image,
                          filterQuality: FilterQuality.low,
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                          cacheHeight: 800,
                          cacheWidth: 800,
                          cache: true,
                        )
                      : ExtendedImage.asset(
                          widget.localImage,
                          filterQuality: FilterQuality.low,
                          fit: BoxFit.cover,
                        )),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(microseconds: 700),
                child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 100),
                    style: selected ? selectedStyle : unselectedStyle,
                    child: Text(
                      widget.el.name,
                      maxLines: 1,
                    ).paddingAll(selected ? 14 : 8)),
              ),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: AnimatedSize(
                    vsync: this,
                    duration: const Duration(seconds: 1),
                    child: Container(
                      width: selected ? 50 : 20,
                      height: selected ? 50 : 20,
                      child: Image.network(widget.el.icon,
                          color: selected
                              ? NewsThemeData.buttonMainColor
                              : Colors.white),
                    ),
                  )),
            ],
          ),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          width: 28,
          height: 28,
          child: Image.asset(
            ICON_SUPERLIKE_CATEGORY,
          ).setVisibility(
              superLike ? VisibilityFlag.visible : VisibilityFlag.gone),
        ),
      ),
    ]);
  }
}
