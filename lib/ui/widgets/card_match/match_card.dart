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
import 'package:sport_news/ui/match_detail/match_detail.dart';

import 'package:sport_news/ui/widgets/card_match/match_card_controller.dart';
import 'package:sport_news/ui/widgets/mouse/mouse_position.dart';

import '../../../constants.dart';
import '../like_widget/like_widget.dart';
import 'package:sport_news/pr_extension.dart';

class MatchCard extends GetWidget<MatchCardController> {
  late String tag;
  MatchCard({required MatchEvent el}) {
    this.tag = el.snapshotId + '_CardListNews';
    Get.put(MatchCardController(match: el, tag: tag), tag: tag);
  }
  var teamName = AutoSizeGroup();

  get controller => Get.find<MatchCardController>(tag: tag);

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    // final key = GlobalKey(debugLabel: el.title);
    return GetBuilder(
        tag: tag,
        init: controller,
        builder: (_) => MousePosition(
            onEnter: (position) {
              controller.hoverItem = true;
            },
            onExit: (position) {
              controller.hoverItem = false;
            },
            child: AnimatedPadding(
              curve: Curves.elasticOut,
              padding: EdgeInsets.all(
                isDesktop && !controller.hoverItem ? 3 : 1,
              ),
              duration: const Duration(seconds: 1),
              child: Card(
                color: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(controller.hoverItem ? 10 : 3),
                ),
                // key: key,
                elevation: controller.hoverItem ? 10 : 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(microseconds: 800),
                              width: double.infinity,
                              child: Material(
                                elevation: controller.hoverItem ? 6 : 0,
                                type: MaterialType.transparency,
                                child: Hero(
                                  tag: controller.match.snapshotId + "image_",
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            controller.hoverItem ? 6 : 3)),
                                    child: ExtendedImage.network(
                                        controller.league != null &&
                                                controller.league!.imageUrl !=
                                                    null
                                            ? controller.league!.imageUrl!
                                            : '',
                                        fit: BoxFit.cover,
                                        cache: true,
                                        retries: 3,
                                        filterQuality: FilterQuality.high,
                                        loadStateChanged:
                                            loadImageStateFunction),
                                  ),
                                ),
                              ),
                            ).paddingOnly(bottom: 13),
                            Positioned(
                              bottom: 0,
                              child: Chip(
                                elevation: controller.hoverItem ? 6 : 4,
                                label: AnimatedPadding(
                                  curve: Curves.fastOutSlowIn,
                                  padding: EdgeInsetsDirectional.all(
                                      controller.hoverItem ? 2 : 0),
                                  duration: const Duration(milliseconds: 200),
                                  child: AutoSizeText(
                                    controller.match.isStarted().b,
                                    maxLines: 1,
                                    minFontSize: 8,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                            fontSize: 14,
                                            color:
                                                controller.match.isStarted().a
                                                    ? Colors.red
                                                    : Colors.white60),
                                  ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        controller.team1!.name.toString(),
                                        group: teamName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                color:
                                                    NewsThemeData.accentColor),
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
                                    child: Image.network(
                                        controller.team1!.imageUrl!),
                                  ),
                                  // Spacer(),
                                  AutoSizeText(
                                    'VS',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                  ),
                                  // Spacer(),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                        controller.team2!.imageUrl!),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        controller.team2!.name.toString(),
                                        group: teamName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                color:
                                                    NewsThemeData.accentColor),
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
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  controller.league != null &&
                                          controller.league!.name != null
                                      ? controller.league!.name!
                                      : '',
                                  minFontSize: 10,
                                  maxFontSize: 14,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: Colors.white54,
                                          fontWeight: FontWeight.bold),
                                ).paddingOnly(left: 6, right: 6),
                                AutoSizeText(
                                  controller.match.schedule.toUtc().toString(),
                                  minFontSize: 5,
                                  maxFontSize: 8,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.white54),
                                ).paddingOnly(left: 6, right: 6, bottom: 6),
                              ]),
                        ),
                        EventStatisticWidget(
                          match: controller.match,
                        ),
                      ],
                    )
                  ],
                ),
              ).addOnTapAnimation(animation_miliseconds: 100,onTap: (){
                _onTapCard();
              }),
            )));
  }

  _onTapCard(){
    Get.toNamed(MatchDetail.page + "?matchId=${controller.match.snapshotId}");
    
  }
}
