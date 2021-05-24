import 'package:flutter/material.dart';
import 'package:sport_news/data/network/categories.dart';
import 'package:sport_news/pr_extension.dart';
import 'package:sport_news/ui/widgets/staggered_user_suggestion.dart';

class StackMatrix extends StatefulWidget {
  final List<FirebaseCategories> items;
  final Function itemSelected;
  final startSize;
  final deltaSize;
  final deltaSizeBig;

  const StackMatrix(
      {Key key,
      this.items,
      this.itemSelected,
      this.startSize = 100.0,
      this.deltaSizeBig = 200.0,
      this.deltaSize = 50.0})
      : super(key: key);

  @override
  _StackMatrixState createState() => _StackMatrixState();
}

class _StackMatrixState extends State<StackMatrix>
    with TickerProviderStateMixin {
  Map<int, List<SuggestionItem>> suggestionMatrix = {
    0: [],
    1: [],
    2: [],
    3: []
  };

  var needUpdateScrollWidth = true;
  var maxHeight = 0;

  var startSize;
  var deltaSize;
  var deltaSizeBig;

  @override
  void initState() {
    super.initState();

    //mark: remove in release
    startSize = widget.startSize;
    deltaSize = widget.deltaSize;
    deltaSizeBig = widget.deltaSizeBig;

    int rowCount = (widget.items.length / 4).round();
    suggestionMatrix = Map.from(suggestionMatrix.map((key, value) {
      final endIndex = (rowCount * (key + 1));
      return MapEntry(
          key,
          widget.items
              .getRange(
                  rowCount * key,
                  endIndex < widget.items.length
                      ? endIndex
                      : widget.items.length)
              .toList()
              .asMap()
              .entries
              .map((element) {
            final val = element.value;
            final i = element.key;
            return SuggestionItem(
              data: val,
              name: val.title,
              image: val.imageUrl,
              icon: val.iconUrl,
              width: startSize,
              height: startSize,
              currentWeight: 1,
              x: (i) * startSize,
              y: (key) * startSize,
            );
          }).toList());
    }));
  }

  @override
  Widget build(BuildContext context) {
    updateWidth();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
          width: maxHeight * startSize,
          height: 4 * deltaSizeBig,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.topCenter,
            children: childerCards(),
          )),
    );
  }

  updateWidth() {
    if (needUpdateScrollWidth) {
      needUpdateScrollWidth = false;
      maxHeight = 0;
      suggestionMatrix.forEach((key, list) {
        final current =
            list.where((element) => element.currentWeight == 1).length;
        final currentExpand =
            list.where((element) => element.currentWeight == 2).length;
        final currentExpandMax =
            list.where((element) => element.currentWeight == 3).length;

        final all = current + (currentExpand * 2) + (currentExpandMax * 2);
        maxHeight = maxHeight < all ? all : maxHeight;
      });
    }
  }

  List<Widget> childerCards() {
    List<Widget> cardsMatrixWidgets = [];

    suggestionMatrix.entries.forEach((columns) {
      int iColumn = columns.key;
      List<SuggestionItem> rowsList = columns.value;
      rowsList.asMap().entries.forEach((rows) {
        int iRow = rows.key;
        SuggestionItem currentRow = rows.value;
        setState(() {
          currentRow.iColumn = iColumn;
          currentRow.iRow = iRow;
        });

        ///
        ///
        ///mark: update widgets
        ///
        //Future.delayed(Duration(milliseconds: 100), () {
        // mark: left
        if (currentRow.iRow > 0) {
          calcOverflowLeft(rowsList.elementAt(currentRow.iRow - 1), currentRow);
        }
        setState(() {
          if (currentRow.iColumn > 0) {
            calcOverflowTop(
                suggestionMatrix[currentRow.iColumn - 1]
                    .elementAt(currentRow.iRow),
                currentRow);

            calcOverflowClosestElement(
                line: suggestionMatrix[currentRow.iColumn - 1],
                current: currentRow);
          }
        });
        //});

        ///
        ///
        ///
        ///get all widgets
        cardsMatrixWidgets.add(AnimatedPositioned.fromRect(
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOutQuint, //fastOutSlowIn,
          child: item(rows.value),
          rect: currentRow.rect,
        ));
      });
    });

    return cardsMatrixWidgets;
  }

  bool calcOverflowClosestElement(
      {@required List<SuggestionItem> line,
      @required SuggestionItem current,
      bool check = false}) {
    for (SuggestionItem element in line) {
      if (current.rect.intersect(element.rect).height > 0 &&
          current.rect.intersect(element.rect).width > 0) {
        if (current.rect.intersect(element.rect).height > 0) {
          if (!check) {
            current.y += element.rect.intersect(current.rect).height;
          }
        }
      }
    }
    return false;
  }

  void calcOverflowLeft(SuggestionItem prev, SuggestionItem current,
      {bool withGravity}) {
    if (prev.right > current.left) {
      current.x += prev.right - current.left;
    } else if (prev.right < current.left) {
      current.x -= current.left - prev.right;
    }
  }

  void calcOverflowTop(SuggestionItem prev, SuggestionItem current) {
    if (current.x == prev.x)
      current.y += prev.rect.intersect(current.rect).height;
  }

  Widget item(SuggestionItem e) {
    return AnimatedSize(
      vsync: this,
      duration: Duration(milliseconds: 400),
      curve: Curves.bounceInOut,
      child: Container(
        height: e.height,
        width: e.width,
        child: Padding(
            padding: EdgeInsets.all(8),
            child: CardItemWidget(
              backgroundColor: e.color,
              iconData: Icons.hd,
              name: e.name,
              el: e,
            )).addOnTap(
          onLongPress: () {
            onLongPressItem(e);

            setState(() {
              needUpdateScrollWidth = true;
            });
          },
          onTap: () {
            onTapItem(e);

            setState(() {
              needUpdateScrollWidth = true;
            });
          },
        ),
      ),
    );
  }

  onTapItem(SuggestionItem e) {
    setState(() {
      if (e.currentWeight <= 1) {
        e.currentWeight = e.currentWeight + 1;
        e.height = e.height + deltaSize;
        e.width = e.width + deltaSize;
      } else {
        e.currentWeight = 1;
        e.height = startSize;
        e.width = startSize;
      }
    });
    widget.itemSelected(e);
  }

  onLongPressItem(
    SuggestionItem e,
  ) {
    setState(() {
      if (e.currentWeight < 3) {
        e.currentWeight = 3;
        e.height = deltaSizeBig;
        e.width = deltaSizeBig;
      } else {
        e.currentWeight = 1;
        e.height = startSize;
        e.width = startSize;
      }
    });
    widget.itemSelected(e);
  }
}
