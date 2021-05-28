import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_news/managers/app_type_checker.dart';
import 'package:sport_news/style/locale/localization.dart';
import 'package:sport_news/ui/recommendations/recommendations/recommendations_bloc.dart';
import 'package:sport_news/pr_extension.dart';
import 'package:sport_news/ui/widgets/custom_progress.dart';
import 'package:sport_news/ui/widgets/fluid_nav_bar/fluid_nav_bar.dart';
import 'package:sport_news/ui/widgets/header_mobile_widget.dart';
import 'package:sport_news/ui/widgets/news_widget_mobile.dart';

import '../../constants.dart';

class RecommendationsPage extends StatefulWidget {
  @override
  _RecommendationsPageState createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  @override
  Widget build(BuildContext c) {
    final isDesktop = isDisplayDesktop(c);

    return Scaffold(
        body: BlocBuilder<RecommendationsBloc, RecommendationsState>(
            bloc: BlocProvider.of<RecommendationsBloc>(context)
              ..add(RecommendationsEvent.init),
            builder: (context, state) {
              // if (state.news == null || state.news.length < 1) {
              //   return CustomProgress();
              // }
              return mobile(isDesktop, state);
            }));
  }

  mobile(bool isDesktop, RecommendationsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderTitleMobileWidget(
            title: NewsLocalizations.of(context).recommended),
        Expanded(
          child: Container(
            child: CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: <Widget>[
                NewsWidgetMobile(
                  news: state.news,
                ),
                bottomWidgetMobile(state: state),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bottomWidgetMobile({RecommendationsState state}) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Center(
            child: state.isLoading
                ? CustomProgress().paddingAll(PADDING_BOTTOM_MEDIUM)
                : Container()),
        state.newsIsEmpty && !state.isLoading
            ? Container(
                constraints: BoxConstraints(minHeight: 300, maxHeight: 700),
                alignment: Alignment(0.0, 0.0),
                child: AutoSizeText(
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
            : Container(),
        SizedBox(
          height: 20,
        )
      ]),
    );
  }
}
