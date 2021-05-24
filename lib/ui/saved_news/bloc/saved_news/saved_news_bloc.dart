import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';

part 'saved_news_event.dart';

part 'saved_news_state.dart';

class SavedNewsBloc extends Bloc<SavedNewsEvent, SavedNewsState> {
  SavedNewsBloc() : super(SavedNewsState([]));
  FirebaseManager firebaseManager = FirebaseManager();
  SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
  List<FirebaseNews> _news = [];

  get news => _news;

  @override
  Stream<SavedNewsState> mapEventToState(SavedNewsEvent event) async* {
    switch (event) {
      case SavedNewsEvent.subscribeToSavedMessages:
        _subscribeToSavedMessages();
        break;
      case SavedNewsEvent.update:
        yield SavedNewsState(news);
        break;
      default:
        addError(Exception('unsupported event'));
    }
  }

  _subscribeToSavedMessages() async {
    sharedPreferenceManager
        .getAllLikedNewsStream()
        .asBroadcastStream()
        .listen((event) {
      if (event != null && event.length > 0) {
        // firebaseManager.getNewsByNewsKeys(event, onNew: (value) {
        //   _news.clear();
        //   _news.addAll(value);
        //   add(SavedNewsEvent.update);
        // });
      } else {
        _news.clear();
        add(SavedNewsEvent.update);
      }
    });
  }
}
