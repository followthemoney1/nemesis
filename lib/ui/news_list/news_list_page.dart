import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_news/constants.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/managers/app_type_checker.dart';
import 'package:sport_news/managers/campaign_manager.dart';
import 'package:sport_news/pr_extension.dart';
import 'package:sport_news/style/locale/localization.dart';
import 'package:sport_news/ui/news_detail/news_detail/news_detail_bloc.dart';
import 'package:sport_news/ui/news_detail/news_detail_page.dart';
import 'package:sport_news/ui/news_list/news_list/news_list_bloc.dart';
import 'package:sport_news/ui/widgets/custom_progress.dart';
import 'package:sport_news/ui/widgets/fluid_nav_bar/fluid_nav_bar.dart';
import 'package:sport_news/ui/widgets/header_topnews_widget_mobile.dart';
import 'package:sport_news/ui/widgets/news_widget_mobile.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() {
    return _NewsListPageState();
  }
}

class _NewsListPageState extends State<NewsListPage>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  // GlobalKey ctkey = GlobalKey();
  var deepLinkOpened = false;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!scrollController.hasClients) return;
        BlocProvider.of<NewsListBloc>(context).showMore(count: 20);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
   

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //developer.log("didChangeDependencies");
  }

  @override
  Widget build(BuildContext c) {
    final isDesktop = isDisplayDesktop(c);
    return Center(
      child: BlocBuilder<NewsListBloc, NewsListState>(
        bloc: BlocProvider.of<NewsListBloc>(context)
          ..add(NewsListEvent.subscribe),
        builder: (_, state) {
          if (state.oneNews != null && !deepLinkOpened) {
            deepLinkOpened = true;

            openDetailPage(newsElement: state.oneNews);
          }

          return mobile(isDesktop, state);
        },
      ),
    );
  }

  mobile(bool isDesktop, NewsListState state) {
    return Container(
      // key: ctkey,
      child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        controller: scrollController,
        slivers: <Widget>[
          HeaderTopNewsWidgetMobile(
            topNews: state.topNews,
          ),
          NewsWidgetMobile(
            news: state.news,
          ),
          bottomWidgetMobile(state: state),
        ],
      ),
    );
  }

  openDetailPage({FirebaseNews newsElement}) {
    //developer.log('-------BAD STATE --------');
    Future.delayed(const Duration(seconds: 1), () async {
      await CampaignManager().updateViewCount(firebaseNews: newsElement);
      Navigator.of(context).push<void>(
        NewsDetailPage.route(
          context,
          GlobalKey(),
          args: newsElement,
        ),
      );
    });
  }

  bottomWidgetMobile({NewsListState state}) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Center(
            child: state.isLoading
                ? CustomProgress()
                    .paddingAll(MediaQuery.of(context).size.height / 2)
                : Container(
                    height: 0,
                    width: 0,
                  )),
        state.newsIsEmpty && !state.isLoading
            ? Container(
                constraints: BoxConstraints(minHeight: 300, maxHeight: 700),
                alignment: Alignment(0.0, 0.0),
                child: Text(
                  NewsLocalizations.of(context).noNewData,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 15),
                  ),
                ),
              )
            : Container(
                height: 0,
                width: 0,
              ),
        SizedBox(
          height: 20,
        )
      ]),
    );
  }
}
