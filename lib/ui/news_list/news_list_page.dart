import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_news/constants.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/managers/app_type_checker.dart';
import 'package:sport_news/managers/campaign_manager.dart';
import 'package:sport_news/pr_extension.dart';
import 'package:sport_news/style/locale/localization.dart';
import 'package:sport_news/ui/news_detail/news_detail/news_detail_bloc.dart';
import 'package:sport_news/ui/news_detail/news_detail_page.dart';
import 'package:sport_news/ui/news_list/news_list_controller.dart';
import 'package:sport_news/ui/widgets/custom_progress.dart';
import 'package:sport_news/ui/widgets/fluid_nav_bar/fluid_nav_bar.dart';
import 'package:sport_news/ui/widgets/news_widget_mobile.dart';

class MatchesListPage extends GetWidget<MatchesListController> {
  final String tag;
  MatchesListPage({required this.tag});

  ScrollController scrollController = ScrollController();
  var context;
  @override
  Widget build(BuildContext c) {
    context = c;
    return Center(
      child: mobile(),
    );
  }

  mobile() {
    return GetBuilder<MatchesListController>(
      tag: tag,
      init: Get.find<MatchesListController>(tag: tag),
      builder: (_) => Container(
        // key: ctkey,
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          controller: scrollController,
          slivers: <Widget>[
            // HeaderTopNewsWidgetMobile(
            //   topNews: state.topNews,
            // ),
            NewsWidgetMobile(
              matches: controller.matches,
            ),

            // bottomWidgetMobile(state: state),
          ],
        ),
      ),
    );
  }

  openDetailPage({FirebaseNews? newsElement}) {
    Navigator.of(context).push<void>(
      NewsDetailPage.route(
        context,
        GlobalKey(),
        args: newsElement,
      ),
    );
  }

  // bottomWidgetMobile({NewsListState state}) {
  //   return SliverList(
  //     delegate: SliverChildListDelegate([
  //       Center(
  //           child: state.isLoading
  //               ? CustomProgress()
  //                   .paddingAll(MediaQuery.of(context).size.height / 2)
  //               : Container(
  //                   height: 0,
  //                   width: 0,
  //                 )),
  //       state.newsIsEmpty && !state.isLoading
  //           ? Container(
  //               constraints: BoxConstraints(minHeight: 300, maxHeight: 700),
  //               alignment: Alignment(0.0, 0.0),
  //               child: AutoSizeText(
  //                 NewsLocalizations.of(context).noNewData,
  //                 textAlign: TextAlign.center,
  //                 style: GoogleFonts.roboto(
  //                   textStyle: Theme.of(context)
  //                       .textTheme
  //                       .bodyText2
  //                       .copyWith(fontSize: 15),
  //                 ),
  //               ),
  //             )
  //           : Container(
  //               height: 0,
  //               width: 0,
  //             ),
  //       SizedBox(
  //         height: 20,
  //       )
  //     ]),
  //   );
  // }
}
