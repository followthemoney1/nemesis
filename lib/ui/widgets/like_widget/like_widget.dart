import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';
import 'package:sport_news/style/theme/gallery_theme_data.dart';
import 'package:sport_news/ui/widgets/like_widget/like_controller.dart';
import 'dart:developer' as developer;
import 'package:sport_news/pr_extension.dart';
import '../../../constants.dart';

class EventStatisticWidget extends GetWidget<EventStatisticController> {
  late String tag;
  EventStatisticWidget({
    required MatchEvent match,
  }) {
    this.tag = match.snapshotId + '_EventStatisticWidget';
    Get.put(EventStatisticController(match: match, tag: tag), tag: tag);
  }

  get controller => Get.find<EventStatisticController>(tag: tag);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventStatisticController>(
      init: controller,
      builder: (_) {
        return Center(
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            //
            //like
            //
            AutoSizeText(
              controller.match.likeCount.toString(),
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.white54),
              maxLines: 3,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              child: Icon(
                controller.likedByUser != null && controller.likedByUser!
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                color: controller.likedByUser != null && controller.likedByUser!
                    ? NewsThemeData.saveButtonColor
                    : Colors.white30,
                size: 15,
              ).paddingOnly(
                  left: PADDING_LR_VERY_SMALL,
                  right: PADDING_LR_MEDIUM,
                  top: 6,
                  bottom: 6),
            ),
            //
            //views
            //
            AutoSizeText(
              controller.match.viewCount.toString(),
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.white54),
              maxLines: 3,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              child: Icon(
                FontAwesomeIcons.eye,
                color: Colors.white30,
                size: 15,
              ).paddingOnly(
                  left: PADDING_LR_VERY_SMALL,
                  right: PADDING_LR_MEDIUM,
                  top: 6,
                  bottom: 6),
            ),

            AutoSizeText(
              controller.match.shareCount.toString(),
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.white54),
              maxLines: 3,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              child: Icon(
                FontAwesomeIcons.shareAlt,
                color: Colors.white30,
                size: 15,
              ).paddingOnly(
                  left: PADDING_LR_VERY_SMALL,
                  right: PADDING_LR_MEDIUM,
                  top: 6,
                  bottom: 6),
            ),
          ]),
        ).addOnTap(
          onTap: () {
            controller.like();
          },
        );
      },
    );
  }
}
