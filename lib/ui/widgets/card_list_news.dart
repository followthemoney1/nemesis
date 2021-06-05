import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/app_type_checker.dart';
import 'package:sport_news/managers/campaign_manager.dart';
import 'package:sport_news/pr_extension.dart';
import 'package:sport_news/ui/news_detail/news_detail/news_detail_bloc.dart';
import 'package:sport_news/ui/news_detail/news_detail_page.dart';

import '../../constants.dart';
import 'like_widget.dart';

class CardListNews extends StatefulWidget {
  final MatchEvent el;

  const CardListNews({required this.el});

  @override
  State<StatefulWidget> createState() {
    return CardListNewsState();
  }
}

class CardListNewsState extends State<CardListNews> {
  late MatchEvent match;

  @override
  void initState() {
    super.initState();
    match = widget.el;
    print(match.matchStreamUrl);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    // final key = GlobalKey(debugLabel: el.title);
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      // key: key,
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Stack(alignment: AlignmentDirectional.topCenter, children: [
              Container(
                width: double.infinity,
                child: Material(
                  type: MaterialType.transparency,
                  child: Hero(
                    tag: match.snapshotId + "image_",
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      child: ExtendedImage.network('',
                          fit: BoxFit.cover,
                          cache: true,
                          retries: 3,
                          filterQuality: FilterQuality.low,
                          loadStateChanged: loadImageStateFunction),
                    ),
                  ),
                ),
              ).paddingOnly(bottom: 13),
              Positioned(
                  bottom: 0,
                  child: Chip(
                      elevation: 4,
                      label: AutoSizeText(
                        match.isStarted().b,
                        maxLines: 1,
                        minFontSize: 8,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 14,
                            color: match.isStarted().a
                                ? Colors.red
                                : Colors.white60),
                      ),),)
            ]),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: match.snapshotId + "name_",
                  child: Material(
                    type: MaterialType.transparency,
                    child: AutoSizeText(
                      match.bo.toString(),
                      style: Theme.of(context).textTheme.headline6,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                // Flexible(
                //   child: LikeWidget(
                //     firebaseNews: el.snapshotId,
                //   ),
                // ),
                // Flexible(
                //   child: cardHintWidget(el, context),
                // ),
              ],
            ).paddingOnly(
                left: PADDING_LR_VERY_SMALL, right: PADDING_LR_MEDIUM),
          ),
        ],
      ),
    ).addOnTap(onTap: () {
      // _tapOnCard(isDesktop: isDesktop, newsElement: el);
    }).paddingOnly(
      left: isDesktop ? 10 : 2,
      top: isDesktop ? 10 : 2,
    );
  }

  cardHintWidget(FirebaseNews el, BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
        flex: 3,
        child: el.channelType == 'rss' || el.channelType == 'tg'
            ? AutoSizeText(
                el.channelName!,
                style: Theme.of(context)
                    .textTheme
                    .overline!
                    .apply(color: Theme.of(context).bottomAppBarColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : Container(),
      ),
      Flexible(
        flex: 2,
        child: AutoSizeText(
          el.creationDate,
          textAlign: TextAlign.right,
          style: Theme.of(context)
              .textTheme
              .overline!
              .apply(color: Theme.of(context).bottomAppBarColor),
          maxLines: 1,
        ),
      ),
    ]).paddingOnly(left: PADDING_LR_VERY_SMALL, right: PADDING_LR_MEDIUM);
  }

  _tapOnCard({
    bool? isDesktop,
    GlobalKey? key,
    required FirebaseNews newsElement,
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
