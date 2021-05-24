import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/managers/app_type_checker.dart';
import 'package:sport_news/managers/campaign_manager.dart';
import 'package:sport_news/pr_extension.dart';
import 'package:sport_news/ui/news_detail/news_detail/news_detail_bloc.dart';
import 'package:sport_news/ui/news_detail/news_detail_page.dart';

import '../../constants.dart';
import 'like_widget.dart';

class CardListNews extends StatefulWidget {
  final FirebaseNews el;

  const CardListNews({@required this.el});

  @override
  State<StatefulWidget> createState() {
    return CardListNewsState();
  }
}

class CardListNewsState extends State<CardListNews> {
  var el;

  @override
  void initState() {
    super.initState();
    el = widget.el;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    // final key = GlobalKey(debugLabel: el.title);
    bool imageNonEmpty = el.images.length > 0 && el.images.first != null;
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      // key: key,
      elevation: 8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              flex: isDesktop ? 4 : 2,
              child: Material(
                  type: MaterialType.transparency,
                  child: Hero(
                      tag: el.heroName + "image_",
                      child: Container(
                        width: isDesktop ? 600 : 100,
                        height: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          child: ExtendedImage.network(
                              imageNonEmpty ? el?.images?.first?.url : "",
                              fit: BoxFit.cover,
                              cache: true,
                              retries: 3,
                              filterQuality: FilterQuality.low,
                              loadStateChanged: loadImageStateFunction),
                        ),
                      ).paddingOnly(right: 6)))),
          Flexible(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: el.heroName + "name_",
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      el.title,
                      style: Theme.of(context).textTheme.headline6,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Flexible(
                  child: LikeWidget(
                    firebaseNews: el,
                  ),
                ),
                Flexible(
                  child: cardHintWidget(el, context),
                ),
              ],
            ).paddingOnly(
                left: PADDING_LR_VERY_SMALL, right: PADDING_LR_MEDIUM),
          ),
        ],
      ),
    ).addOnTap(onTap: () {
      _tapOnCard(isDesktop: isDesktop, newsElement: el);
    }).paddingOnly(
        left: 10,
        right: 10,
        top: isDesktop ? 20 : 10,
        bottom: isDesktop ? 30 : 10);
  }

  cardHintWidget(FirebaseNews el, BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
        flex: 3,
        child: el.channelType == 'rss' || el.channelType == 'tg'
            ? Text(
                el.channelName,
                style: Theme.of(context)
                    .textTheme
                    .overline
                    .apply(color: Theme.of(context).bottomAppBarColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : Container(),
      ),
      Flexible(
        flex: 2,
        child: Text(
          el.creationDate,
          textAlign: TextAlign.right,
          style: Theme.of(context)
              .textTheme
              .overline
              .apply(color: Theme.of(context).bottomAppBarColor),
          maxLines: 1,
        ),
      ),
    ]).paddingOnly(left: PADDING_LR_VERY_SMALL, right: PADDING_LR_MEDIUM);
  }

  _tapOnCard({
    bool isDesktop,
    GlobalKey key,
    FirebaseNews newsElement,
  }) async {
    await CampaignManager().updateViewCount(firebaseNews: newsElement);

    Navigator.of(context).push<void>(
      NewsDetailPage.route(
        context,
        GlobalKey(),
        args: newsElement,
      ),
    );
  }
}
