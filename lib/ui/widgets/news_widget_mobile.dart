import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/managers/app_type_checker.dart';
import 'card_list_news.dart';

class NewsWidgetMobile extends StatelessWidget {
  final List<FirebaseNews> news;
  final ScrollController scrollController = ScrollController();

  NewsWidgetMobile({@required this.news});

  @override
  Widget build(BuildContext context) {
    if (news == null || news.length < 1) {
      return SliverList(delegate: SliverChildListDelegate([Container()]));
    }

    final isDesktop = isDisplayDesktop(context);
    int _tempIndex = -1;
    return AnimationLimiter(
      child: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: isDesktop ? 2 : 3,
            crossAxisCount: isDesktop ? 2 : 1),
        delegate: SliverChildListDelegate(
          news.map((el) {
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
