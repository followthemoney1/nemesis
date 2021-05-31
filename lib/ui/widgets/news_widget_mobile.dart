import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/app_type_checker.dart';
import 'card_list_news.dart';

class NewsWidgetMobile extends StatelessWidget {
  final List<MatchEvent> matches;
  final ScrollController scrollController = ScrollController();

  NewsWidgetMobile({@required this.matches});

  @override
  Widget build(BuildContext context) {
    if (matches == null || matches.length < 1) {
      return SliverList(delegate: SliverChildListDelegate([Container()]));
    }

    int _tempIndex = -1;
    return AnimationLimiter(
      child: SliverGrid(
        // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 4),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            
            crossAxisCount: 4,
            childAspectRatio: 1.2, ),
        delegate: SliverChildListDelegate(
          matches.map((el) {
            _tempIndex++;

            return AnimationConfiguration.staggeredList(
              position: _tempIndex,
              duration: const Duration(milliseconds: 600),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: CardListNews(el: el),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
