import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sport_news/data/network/categories.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';
import 'dart:developer' as developer;

part 'recommendations_event.dart';

part 'recommendations_state.dart';

class RecommendationsBloc
    extends Bloc<RecommendationsEvent, RecommendationsState> {
  RecommendationsBloc() : super(RecommendationsState(isLoading: true));
  SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
  FirebaseManager firebaseManager = FirebaseManager();

  List<FirebaseNews> _news = [];
  bool isLoading = true;
  get news => _news;

  @override
  Stream<RecommendationsState> mapEventToState(
      RecommendationsEvent event) async* {
    switch (event) {
      case RecommendationsEvent.init:
        getRecomendation();
        break;
      case RecommendationsEvent.update:
        yield RecommendationsState(
            news: news,
            isLoading: isLoading,
            newsIsEmpty: news == null || news.isEmpty);
        break;
      default:
        addError(Exception('unsupported event'));
    }
  }

  getRecomendation() async {
    //mark: add check on null data
    Future.delayed(const Duration(minutes: 2), () {
      if (_news == null || _news.length < 1) {
        isLoading = false;
        add(RecommendationsEvent.update);
      }
    });
    _news.clear();

    List<String> categoryList = await sharedPreferenceManager.getCategoryList();
    // firebaseManager.getNewsByCategory(categoryList, onNew: (oneNews) {
    //   if (_news.where((element) => oneNews.key == element.key).length > 0)
    //     return;

    //   if (DateTime.now().difference(oneNews.timeStamp).inDays < 7) {
    //     _news.add(oneNews);
    //     _news.sort((e1, e2) => e2.timeStamp.compareTo(e1.timeStamp));
    //   }
    //   isLoading = false;
    //   add(RecommendationsEvent.update);
    // });
  }
}
