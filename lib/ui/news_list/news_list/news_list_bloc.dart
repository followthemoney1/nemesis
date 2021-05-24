import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sport_news/data/network/categories.dart';
import 'package:sport_news/data/network/firebase_languages.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/network_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';
import 'dart:developer' as developer;

part 'news_list_event.dart';

part 'news_list_state.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  NewsListBloc() : super(NewsListState(isLoading: true));

  FirebaseManager firebaseManager = FirebaseManager();
  SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
  NetworkManager networkManager = NetworkManager();
  StreamController<FirebaseNews> newsDataController =
      StreamController<FirebaseNews>.broadcast();
  List<FirebaseNews> topNewsDataController = [];

  List<FirebaseNews> _news = [];
  List<FirebaseNews> _fetchedNews = [];
  int _newsCount = 40;
  bool filtered = false;
  get news => _news.length > _newsCount
      ? _news.getRange(0, _newsCount).toList()
      : _news;
  // get news => _news;
  hasMoreItems({@required int count}) => news.length > count;
  bool _subscribe = false;
  bool _isLoadingNews = true;

  var branchDeeplinkNewsId;
  init() {
    listenDynamicLinks();
  }

  StreamSubscription<Map> streamSubscription;
  StreamController<String> controllerData = StreamController<String>();
  StreamController<String> controllerInitSession = StreamController<String>();
  StreamController<String> controllerUrl = StreamController<String>();
  void listenDynamicLinks() async {
    // streamSubscription = FlutterBranchSdk.initSession().listen((data) {
    //   //developer.log('listenDynamicLinks - DeepLink Data: $data');
    //   controllerData.sink.add((data.toString()));
    //   if (data.containsKey('+clicked_branch_link') &&
    //       data['+clicked_branch_link'] == true) {
    //     //developer.log('Custom string: ${data['news_id']}');
    //     branchDeeplinkNewsId = data['news_id'];
    //     add(NewsListEvent.openDeepLink);
    //   }
    // }, onError: (error) {
    //   PlatformException platformException = error as PlatformException;
    //   //developer.log('InitSession error: ${platformException.code} - ${platformException.message}');
    //   controllerInitSession.add(
    //       'InitSession error: ${platformException.code} - ${platformException.message}');
    // });
  }

  @override
  Stream<NewsListState> mapEventToState(NewsListEvent event) async* {
    switch (event) {
      case NewsListEvent.subscribe:
        init();

        if (!_subscribe) getNews(count: _newsCount);
        _subscribe = true;

        _getTopNews();
        _subscribeToNews();

        break;
      case NewsListEvent.update:
        yield NewsListState(
            news: news,
            topNews: topNewsDataController,
            isLoading: _isLoadingNews,
            newsIsEmpty: news == null || news.isEmpty);

        break;

      case NewsListEvent.openDeepLink:
        if (branchDeeplinkNewsId != null) {
          final oneNews = await openNewsById();

          yield NewsListState(
              news: news,
              topNews: topNewsDataController,
              isLoading: _isLoadingNews,
              oneNews: oneNews,
              newsIsEmpty: news == null || news.isEmpty);
          branchDeeplinkNewsId = null;
          //developer.log('------onnew state----');
          return;
        }
        break;
      default:
        addError(Exception('unsupported event'));
    }
  }

  Future<FirebaseNews> openNewsById() async {
    // //developer.log('_________opening_______');
    // final oneNews =
    //     await firebaseManager.getOneNewsByNewsKey(branchDeeplinkNewsId);
    // //developer.log(oneNews.toString());
    // return oneNews;
  }

  _getTopNews() async {
    // FirebaseLanguages groupKey =
    //     await firebaseManager.getFirebaseLangKeyByLang();
    // if (groupKey != null) {
    //   topNewsDataController
    //       .addAll(await networkManager.getTopNewsByGroupKey(groupKey.groupKey));
    //   add(NewsListEvent.update);
    // }
  }

  getNews({@required int count}) async {
    // _newsCount += count;
    // firebaseManager.getFirebaseNews(
    //     newsDataController: newsDataController, count: count);
  }

  showMore({@required int count}) {
    _newsCount += count;
    add(NewsListEvent.update);
  }

  _subscribeToNews() {
    //mark: add check on null data
    Future.delayed(const Duration(minutes: 2), () {
      if (_fetchedNews == null || _fetchedNews.length < 1) {
        _isLoadingNews = false;
        add(NewsListEvent.update);
      }
    });

    newsDataController.stream.asBroadcastStream().listen((event) {
      if (_news.where((element) => event.key == element.key).length > 0) return;
      _news.add(event);
      _news.sort((e1, e2) => e2.timeStamp.compareTo(e1.timeStamp));
      _fetchedNews = _news;
      _isLoadingNews = false;

      if (!filtered) add(NewsListEvent.update);
    });
    // sharedPreferenceManager
    //     .getAllLikedNewsStream()
    //     .asBroadcastStream()
    //     .listen((event) {
    //   if (event != null) {
    //     _news.forEach((news) {
    //       if (!event.contains(news.key) && news.likedByUserTemp) {
    //         --news.likeCount;
    //       }
    //       news.likedByUserTemp = event.contains(news.key) ? true : false;
    //     });
    //     add(NewsListEvent.update);
    //   }
    // });
  }

  setLike({FirebaseNews el}) async {
    sharedPreferenceManager.likeNews(
        el.key, !(await sharedPreferenceManager.getLikeNews(el.key)));
  }

  Future<bool> getLike({FirebaseNews el}) async {
    return await sharedPreferenceManager.getLikeNews(el.key);
  }

  filterNews(List<FirebaseCategories> categories) async {
    if (categories.isNotEmpty) {
      List<FirebaseNews> filteredNews = [];
      categories.forEach((category) {
        List<FirebaseNews> categoryNews = _fetchedNews
            .where((element) => element.categoryKey == category.key)
            .toList();
        filteredNews.addAll(categoryNews);
      });
      filtered = true;
      _news = filteredNews;
    } else {
      filtered = false;
      _news = _fetchedNews;
    }
    add(NewsListEvent.update);
  }
}
