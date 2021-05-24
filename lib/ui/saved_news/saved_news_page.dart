import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_news/style/locale/localization.dart';
import 'package:sport_news/ui/saved_news/bloc/saved_news/saved_news_bloc.dart';
import 'package:sport_news/ui/widgets/fluid_nav_bar/fluid_nav_bar.dart';
import 'package:sport_news/ui/widgets/header_mobile_widget.dart';
import 'package:sport_news/ui/widgets/news_widget_mobile.dart';

class SavedNewsPage extends StatefulWidget {
  SavedNewsPage({Key key}) : super(key: key);

  @override
  _SavedNewsPageState createState() => _SavedNewsPageState();
}

class _SavedNewsPageState extends State<SavedNewsPage> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SavedNewsBloc>(context)
        ..add(SavedNewsEvent.subscribeToSavedMessages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SavedNewsBloc, SavedNewsState>(
        bloc: BlocProvider.of<SavedNewsBloc>(context),
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTitleMobileWidget(
                  title: NewsLocalizations.of(context).saved),
              Expanded(
                child: CustomScrollView(
                    physics: ClampingScrollPhysics(),
                    controller: scrollController,
                    slivers: <Widget>[
                      NewsWidgetMobile(news: state.news),
                      bottomWidgetMobile(state),
                    ]),
              ),
            ],
          );
        },
      ),
    );
  }

  bottomWidgetMobile(SavedNewsState state) {
    return SliverList(
      delegate: SliverChildListDelegate([
        state.news == null || state.news.length < 1
            ? Container(
                constraints: BoxConstraints(minHeight: 300, maxHeight: 700),
                alignment: Alignment(0.0, 0.0),
                child: Text(
                  NewsLocalizations.of(context).noSavedNewsYet,
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
          height:  20,
        )
      ]),
    );
  }
}
