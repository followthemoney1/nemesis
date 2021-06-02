import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/managers/campaign_manager.dart';
import 'package:sport_news/pr_extension.dart';
import 'package:sport_news/style/locale/localization.dart';
import 'package:sport_news/style/theme/gallery_theme_data.dart';
import 'package:sport_news/ui/news_detail/news_detail/news_detail_bloc.dart';
import 'package:sport_news/ui/widgets/b_b_c_reference_news_button.dart';
import 'package:sport_news/ui/widgets/expand_item_transition.dart';
import 'package:sport_news/ui/widgets/gradient_button.dart';
import 'package:sport_news/ui/widgets/like_widget.dart';
import 'package:sport_news/ui/widgets/visibility.dart';

import '../../constants.dart';

class NewsDetailPage extends StatefulWidget {
  static final String tag = '/news-detail-page';
  final arguments;
  final widgetKey;

  NewsDetailPage({Key key, this.arguments, this.widgetKey})
      : //assert(parentContext != null),
        super(key: key);

  static Route<dynamic> route(BuildContext c, GlobalKey key, {@required args}) {
    final RenderBox box = key.currentContext.findRenderObject();
    final Rect sourceRect = box.localToGlobal(Offset.zero) & box.size;

    return PageRouteBuilder<void>(
        pageBuilder: (BuildContext context, _, __) => ExpandItemPageTransition(
              source: sourceRect,
              child: NewsDetailPage(
                arguments: args,
                widgetKey: key,
              ),
            ),
        transitionDuration: const Duration(milliseconds: 600),
        barrierDismissible: true,
        opaque: false,
        fullscreenDialog: true);
  }

  @override
  _NewsDetailPageState createState() {
    return _NewsDetailPageState();
  }
}

class _NewsDetailPageState extends State<NewsDetailPage>
    with TickerProviderStateMixin {
  bool updateArgs = false;
  FirebaseNews arguments;
  ScrollController scrollController = ScrollController();
  double defaultOffset = 54;
  double padding = 0;
  bool needPadding = true;
  AnimationController _animationController;
  Animation animation;
  var titleWidget;
  var isTitleExpanded = false;
  double maxHeight(BuildContext c) => MediaQuery.of(c).size.height;
  var canChangePadding = true;
  PageController topImagesDetailScreenPageController = PageController();
  NewsDetailBloc bloc = NewsDetailBloc();
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController
        ..addListener(() {
          _scrollListener();
        });
    });
    initAnimation();
  }

  void initAnimation() {
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = ColorTween(
      begin: Colors.black.withOpacity(0),
      end: Colors.black.withOpacity(0.8),
    ).animate(_animationController)
      ..addListener(() {
        if (_animationController.isCompleted) {}
      });

    Future.delayed(const Duration(milliseconds: 400), () {
      _animationController..forward();
    });
  }

  _scrollListener() {
    if (!scrollController.offset.isNegative) {
      addOrRemovePadding(remove: false);
    } else {
      addOrRemovePadding(remove: true);
    }
  }

  addOrRemovePadding({@required bool remove = true}) {
    if (canChangePadding) {
      setState(() {
        canChangePadding = false;
        needPadding = remove;
        updateTitleText();
      });
      Future.delayed(const Duration(milliseconds: 600), () {
        setState(() {
          canChangePadding = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _getArgs();

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Material(
          color: (animation.value as Color),
          child: body(),
        );
      },
    );
  }

  _getArgs() async {
    if (!updateArgs) {
      setState(() {
        updateArgs = true;
        if (ModalRoute.of(context).settings.arguments == null) {
          arguments = widget.arguments;
        } else {
          arguments = ModalRoute.of(context).settings.arguments;
        }
        updateTitleText();
        //developer.log('arguments = ${arguments.toJson()}');
      });
      assert(arguments != null);

      if (arguments.isWebView) {
        openUrl();
      }
    }
  }

  body() {
    return BlocListener(
        bloc: bloc,
        listener: (context, state) {},
        child: SafeArea(
            top: true,
            bottom: true,
            right: false,
            left: false,
            child: mobile()));
  }

  mobile() {
    return AnimatedContainer(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 600),
      padding: EdgeInsets.only(
        left: (!needPadding) ? 0 : PADDING_LR_BIG_DETAIL,
        right: (!needPadding) ? 0 : PADDING_LR_BIG_DETAIL,
        top: (!needPadding) ? 0 : PADDING_TOP_BIG_DETAIL,
        bottom: (!needPadding) ? 0 : PADDING_BOTTOM_BIG_DETAIL,
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  closeWidget(),
                  arrowUpWidget(),
                  shareWidget(),
                ]),
            Expanded(
              child: Container(
                // constraints: BoxConstraints(
                //     minHeight: needPadding ? 100 : maxHeight(context)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 30,
                        spreadRadius: 4,
                      ),
                    ]),
                child: Card(
                  borderOnForeground: false,
                  elevation: 4,
                  key: widget.key,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Theme.of(context).cardColor,
                  child: SingleChildScrollView(
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        children: [
                          Material(
                            type: MaterialType.transparency,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                              child: TopImagesDetailScreen(
                                images: arguments.images,
                                heroName: arguments.heroName + "image_",
                                topImagesDetailScreenPageController:
                                    topImagesDetailScreenPageController,
                              ),
                            ),
                          ).paddingAll(PADDING_LR_MEDIUM),
                          dateAndLikeWidgetMobile(news: arguments),
                          Container(
                            child: Column(
                              children: [
                                //
                                Row(children: [
                                  Expanded(
                                    child: Hero(
                                      tag: arguments.heroName + "name_",
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: AnimatedSize(
                                          vsync: this,
                                          duration:
                                              const Duration(milliseconds: 100),
                                          child: titleWidget,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BBCReferenceNewsButton(
                                    innerText: arguments.channelName,
                                    padding: 100,
                                  )
                                      .addOnTap(onTap: () => onTapBBC())
                                      .setVisibility(
                                          arguments.channelType == 'rss' ||
                                                  arguments.channelType == 'tg'
                                              ? VisibilityFlag.visible
                                              : VisibilityFlag.gone),
                                ]).paddingOnly(top: PADDING_TOP_SMALL),

                                // AnimatedSize(
                                //   vsync: this,
                                //   duration: const Duration(milliseconds: 400),
                                //   child: HtmlWidget(
                                //     arguments.text,
                                //     hyperlinkColor:
                                //         NewsThemeData.buttonMainColor,
                                //     onTapUrl: (link) {
                                //       //developer.log('launch link = ${link}');
                                //       launchURL(link);
                                //     },
                                //     textStyle: GoogleFonts.roboto(
                                //         textStyle: Theme.of(context)
                                //             .textTheme
                                //             .bodyText2
                                //             .copyWith(
                                //                 fontWeight: FontWeight.w300)),
                                //   ).paddingOnly(
                                //       top: PADDING_TOP_MEDIUM,
                                //       bottom: PADDING_TOP_MEDIUM),
                                // ),

                                arguments.isWebView
                                    ? Container(
                                        child: GradientButton(
                                          innerText:
                                              NewsLocalizations.of(context)
                                                  .watchAVideo,
                                          padding: 60,
                                        ).addOnTap(onTap: () => openUrl()),
                                      )
                                    : Container(),
                              ],
                            ),
                          ).paddingAll(8),
                        ],
                      )),
                ).paddingOnly(bottom: 4),
              ),
            ),
          ]),
    );
  }

  updateTitleText() async {
    if (isTitleExpanded) return;
    if (needPadding) {
      titleWidget = AutoSizeText(arguments.title,
          maxFontSize: 26,
          minFontSize: 18,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6);
    } else {
      isTitleExpanded = true;
      titleWidget = AutoSizeText(arguments.title,
          maxFontSize: 26,
          minFontSize: 18,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6);
    }
  }

  openUrl() async {
    final link =
        await CampaignManager().generateFinalLink(arguments.webViewUrl);
    CampaignManager().updateLinkViewCount(firebaseNews: arguments);
    launchURL(link);
  }

  onTapBBC() {
    if (arguments.channelType == 'rss') {
      launchURL(arguments.source);
    } else if (arguments.channelType == 'tg') {
      launchURL('https://t.me/${arguments.channelId}');
    }
  }

  Widget closeWidget() {
    return IconButton(
      onPressed: () {
        _animationController.duration = Duration(milliseconds: 300);
        _animationController.reverse().then((value) async {
          topImagesDetailScreenPageController.jumpToPage(0);
          Navigator.of(context).pop();
        });
      },
      icon: Icon(
        Icons.close,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget arrowUpWidget() {
    return Hero(
        tag: 'DetailIconArrowHero',
        child: IconButton(
            onPressed: null,
            icon: Icon(
              !needPadding
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_up,
              color: Colors.white,
              size: 32,
            )));
  }

  Widget shareWidget() {
    return IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.share,
          color: Colors.white,
          size: 16,
        ));
  }

  dateAndLikeWidgetMobile({@required FirebaseNews news}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: AutoSizeText(
            news.creationDate,
            textAlign: TextAlign.left,
            style:
                TextStyle(color: Theme.of(context).buttonColor, fontSize: 12),
          ),
        ),
        LikeWidget(firebaseNews: news),
      ],
    ).paddingOnly(left: PADDING_LR_MEDIUM, right: PADDING_LR_MEDIUM);
  }
}

class TopImagesDetailScreen extends StatefulWidget {
  final List<FirebaseImagesNews> images;
  final String heroName;
  final PageController topImagesDetailScreenPageController;
  const TopImagesDetailScreen(
      {Key key,
      this.images,
      this.heroName,
      this.topImagesDetailScreenPageController})
      : super(key: key);

  @override
  _TopImagesDetailScreenState createState() => _TopImagesDetailScreenState();
}

class _TopImagesDetailScreenState extends State<TopImagesDetailScreen> {
  var pageIndex = 0;
  double maxHeight(BuildContext c) => MediaQuery.of(c).size.height;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return topImage();
  }

  topImage() {
    return Container(
      constraints:
          BoxConstraints(minHeight: 100, maxHeight: maxHeight(context) / 4),
      child: PageView.builder(
        controller: widget.topImagesDetailScreenPageController,
        itemBuilder: (context, position) {
          pageIndex = position;
          if (pageIndex == 0) {
            return Hero(
              tag: widget.heroName,
              child: _image(
                widget.images == null || widget.images.length < 1
                    ? ""
                    : widget.images.elementAt(position).url,
              ),
            );
          }
          return _image(
            widget.images == null || widget.images.length < 1
                ? ""
                : widget.images.elementAt(position).url,
          );
        },
        itemCount: widget.images == null || widget.images.length < 1
            ? 0
            : widget.images.length,
      ),
    );
  }

  _image(
    String url,
  ) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        child: ExtendedImage.network(url,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            loadStateChanged: loadImageStateFunction));
  }
}
