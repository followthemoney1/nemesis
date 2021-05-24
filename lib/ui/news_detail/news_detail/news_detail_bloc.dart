import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';

import '../../../constants.dart';
import 'dart:developer' as developer;

part 'news_detail_event.dart';
part 'news_detail_state.dart';

class NewsDetailBloc extends Cubit<bool> {
  NewsDetailBloc() : super(true);
  FirebaseManager _firebaseManager = FirebaseManager();
  SharedPreferenceManager _sharedPreferenceManager = SharedPreferenceManager();
  

  // @override
  // Stream<NewsDetailState> mapEventToState(NewsDetailEvent event) async* {
  //   switch (event) {
  //     case NewsDetailEvent.init:
  //       yield NewsDetailState();
  //       break;
  //     default:
  //       addError(Exception('unsupported event'));
  //   }
  // }

  init() {}

  
}
