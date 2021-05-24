import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/managers/app_type_checker.dart';
import 'package:sport_news/managers/campaign_manager.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/pr_extension.dart';
import 'package:sport_news/style/locale/localization.dart';
import 'package:sport_news/ui/filter/filter_page.dart';
import 'package:sport_news/ui/news_detail/news_detail/news_detail_bloc.dart';
import 'package:sport_news/ui/news_detail/news_detail_page.dart';
import 'package:sport_news/ui/widgets/custom_progress.dart';
import 'package:sport_news/ui/widgets/sport_news_icons_icons.dart';
import 'package:sport_news/ui/widgets/visibility.dart';
import '../../constants.dart';
import 'header_mobile_widget.dart';
import 'like_widget.dart';
import 'dart:developer' as developer;

class HeaderTopNewsWidgetMobile extends StatefulWidget {
  final List<FirebaseNews> topNews;

  const HeaderTopNewsWidgetMobile({@required this.topNews});

  @override
  _HeaderTopNewsWidgetMobileState createState() =>
      _HeaderTopNewsWidgetMobileState();
}

class _HeaderTopNewsWidgetMobileState extends State<HeaderTopNewsWidgetMobile>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: HeaderTitleMobileWidget(
                  title: NewsLocalizations.of(context).titleNews),
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, FilterPage.tag),
              icon: Theme.of(context).colorScheme.secondaryVariant ==
                      Color(0xFFFFCC00)
                  ? ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Theme.of(context).colorScheme.secondaryVariant,
                            Theme.of(context).colorScheme.secondary
                          ],
                        ).createShader(bounds);
                      },
                      child: Icon(SportNewsIcons.filter, color: Colors.white)
                          .paddingOnly(right: PADDING_LR_MEDIUM))
                  : Icon(SportNewsIcons.filter)
                      .paddingOnly(right: PADDING_LR_MEDIUM),
              iconSize: 24,
              alignment: Alignment.centerRight,
            ),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          vsync: this,
          child: (widget.topNews == null || widget.topNews.length < 1)
              ? Container(
                  key: UniqueKey(),
                )
              : topElement(context: context),
        )
      ]),
    );
  }

  topElement({BuildContext context}) {
    final el = widget.topNews.first;
    bool imageNonEmpty = el.images.length > 0 && el.images.first != null;
    final isDesktop = isDisplayDesktop(context);
    // GlobalKey key = GlobalKey();

    return Material(
      key: UniqueKey(),
      type: MaterialType.transparency,
      child: Container(
        constraints: BoxConstraints(maxHeight: 300),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    NewsLocalizations.of(context).topNews,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Expanded(
                    child: Text(
                      el.creationDate,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Theme.of(context).buttonColor, fontSize: 12),
                    ),
                  )
                ],
              ).paddingOnly(top: PADDING_TOP_SMALL),
              Expanded(
                child: Hero(
                  tag: "header_immg_" + el.heroName,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: ExtendedImage.network(
                          imageNonEmpty ? el.images?.first?.url : "",
                          // key: key,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          cache: true,
                        ),
                      ),
                    ).paddingAll(8),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      el.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Theme.of(context).buttonColor, fontSize: 12),
                    ),
                  ),
                  LikeWidget(
                    firebaseNews: el,
                  ),
                ],
              ),
            ]),
      ).paddingAll(PADDING_LR_MEDIUM),
    ).addOnTap(
      onTap: () {
        _tapOnCard(
            isDesktop: isDesktop,  newsElement: el, context: context);
      },
    );
  }

  onTapBBC({FirebaseNews news}) {
    if (news.channelType == 'rss') {
      launchURL(news.source);
    } else if (news.channelType == 'tg') {
      launchURL('https://t.me/${news.channelId}');
    }
  }

  _tapOnCard(
      {bool isDesktop,
      GlobalKey key,
      FirebaseNews newsElement,
      BuildContext context}) async {
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
