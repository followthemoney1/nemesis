import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/app_type_checker.dart';
import 'card_match/match_card.dart';

class NewsWidgetMobile extends StatelessWidget {
  final List<MatchEvent> matches;
  final ScrollController scrollController = ScrollController();

  NewsWidgetMobile({required this.matches});
  final listShowItemDuration = Duration(seconds: 4);

  @override
  Widget build(BuildContext context) {
    if (matches == null || matches.length < 1) {
      return SliverList(delegate: SliverChildListDelegate([Container()]));
    }

    return LiveSliverGrid(
      controller: scrollController,
      // delay: listShowItemDuration * (matches.length + 1),
      itemCount: matches.length,
      gridDelegate:
          // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 4),
          SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, position, animation) =>
          MatchCard(el: matches.elementAt(position)),
    );
  }
}
