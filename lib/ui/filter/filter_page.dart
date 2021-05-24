import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_news/style/locale/localization.dart';
import 'package:sport_news/ui/filter/filter/filter_bloc.dart';
import 'package:sport_news/ui/news_list/news_list/news_list_bloc.dart';
import 'package:sport_news/ui/widgets/custom_progress.dart';

import '../../constants.dart';

class FilterPage extends StatefulWidget {
  static final String tag = '/filter-page';

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(NewsLocalizations.of(context).filters)),
        body: BlocBuilder<FilterBloc, FilterState>(
            bloc: BlocProvider.of<FilterBloc>(context)..add(FilterEvent.init),
            builder: (context, state) {
              return state.allCategories == null ||
                      state.allCategories.length < 1
                  ? Center(child: CustomProgress())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(
                              left: PADDING_LR_BIG_DETAIL,
                              right: PADDING_LR_BIG_DETAIL,
                              bottom: PADDING_LR_BIG_DETAIL),
                          child: ListView.separated(
                            itemCount: state.allCategories.length,
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(),
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                selected: state.selectedCategories
                                    .contains(state.allCategories[index]),
                                selectedTileColor:
                                    Theme.of(context).primaryColor ==
                                            Colors.black
                                        ? Theme.of(context).colorScheme.surface
                                        : Theme.of(context).buttonColor,
                                onTap: () {
                                  BlocProvider.of<FilterBloc>(context)
                                      .pickCategory(
                                          state.allCategories[index],
                                          state.selectedCategories.contains(
                                              state.allCategories[index]));
                                },
                                title: Text(state.allCategories[index].title),
                              );
                            },
                          ),
                        )),
                        Padding(
                          padding: EdgeInsets.all(PADDING_LR_MEDIUM),
                          child: MaterialButton(
                              minWidth: FILTER_BUTTON_MIN_WIDTH,
                              height: FILTER_BUTTON_MIN_HEIGHT,
                              color: Theme.of(context).buttonColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      BUTTON_BORDER_RADIUS)),
                              onPressed: () {
                                BlocProvider.of<FilterBloc>(context)
                                    .add(FilterEvent.applyFilter);
                                BlocProvider.of<NewsListBloc>(context)
                                    .filterNews(state.selectedCategories);
                                Navigator.pop(context);
                              },
                              child: Text(NewsLocalizations.of(context).select,
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      .apply(color: Colors.white))),
                        )
                      ],
                    );
            }));
  }
}
