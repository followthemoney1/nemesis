import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/app_type_checker.dart';
import 'package:sport_news/managers/campaign_manager.dart';
import 'package:sport_news/style/theme/gallery_theme_data.dart';
import 'package:sport_news/ui/news_detail/news_detail/news_detail_bloc.dart';
import 'package:sport_news/ui/news_detail/news_detail_page.dart';
import 'package:sport_news/ui/widgets/card_match/match_card_controller.dart';

import '../../../constants.dart';
import '../like_widget/like_widget.dart';

class CardListNews extends GetWidget<MatchCardController> {
  late String tag;
  CardListNews({required MatchEvent el}) {
    this.tag = el.snapshotId + '_CardListNews';
    Get.put(MatchCardController(match: el, tag: tag), tag: tag);
  }
var teamName = AutoSizeGroup();

  get controller => Get.find<MatchCardController>(tag: tag);

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
      child: GetBuilder(
        tag: tag,
        init: controller,
        builder: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child:
                  Stack(alignment: AlignmentDirectional.topCenter, children: [
                Container(
                  width: double.infinity,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Hero(
                      tag: controller.match.snapshotId + "image_",
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
                      controller.match.isStarted().b,
                      maxLines: 1,
                      minFontSize: 8,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 14,
                          color: controller.match.isStarted().a
                              ? Colors.red
                              : Colors.white60),
                    ),
                  ),
                )
              ]),
            ),

            (controller.team1 == null || controller.team2 == null)
                ? CircularProgressIndicator()
                : Flexible(
                    flex: 2,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeText(
                                
                                controller.team1!.name.toString(),
                                group:teamName,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: NewsThemeData.accentColor),
                                maxLines: 1,
                                minFontSize: 5,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              ),
                              AutoSizeText(
                                '20%',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.white70),
                                maxLines: 1,
                                minFontSize: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(controller.team1!.imageUrl!),
                          ),
                          // Spacer(),
                          AutoSizeText('VS',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 10
                          ),),
                          // Spacer(),
                          Container(
                            width: 40,
                            height: 40,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(controller.team2!.imageUrl!),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeText(
                                controller.team2!.name.toString(),
                                 group:teamName,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: NewsThemeData.accentColor),
                                maxLines: 1,
                                minFontSize: 5,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              ),
                              AutoSizeText(
                                '20%',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.white70),
                                maxLines: 1,
                                minFontSize: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ]),
                  ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child:AutoSizeText(
                  'DOTA 2 ASIAN CHANMPIONSHIP',
                  minFontSize: 3,
                  maxFontSize: 10,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white54),
                ).paddingOnly(left: 6,right: 6),
                ),
                EventStatisticWidget(
                  match: controller.match,
                ),
              ],
            )
            // Flexible(
            //   child: LikeWidget(
            //     firebaseNews: el.snapshotId,
            //   ),
            // ),
            // Flexible(
            //   child: cardHintWidget(el, context),
            // ),
          ],
        ),
      ),
    ).paddingOnly(
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

  // _tapOnCard({
  //   bool? isDesktop,
  //   GlobalKey? key,
  //   required FirebaseNews newsElement,
  // }) async {
  //   await CampaignManager().updateViewCount(firebaseNews: newsElement);

  //   Navigator.of(context).push<void>(
  //     NewsDetailPage.route(
  //       context,
  //       GlobalKey(),
  //       args: newsElement,
  //     ),
  //   );
  // }
}