import 'dart:io';

import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';
import 'dart:developer' as developer;

import 'package:url_launcher/url_launcher.dart';

class CampaignManager {
  static final CampaignManager _singleton = new CampaignManager._internal();
  SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
  FirebaseManager firebaseManager = FirebaseManager();
  factory CampaignManager() {
    return _singleton;
  }

  CampaignManager._internal() {
    _init();
  }

  _init() {}

 

  // Future<void> getFbDeepLink() async {
  //   FacebookDeeplinks().onDeeplinkReceived.listen((data) {
  //     final params =
  //         (data != null && data.length > 0) ? data.split("?")[1] : data;
  //     //developer.log('fb deeplink data = $params');
  //     if (params != null && params.length > 0)
  //       sharedPreferenceManager.saveDeepLinkData(params);
  //   });
  //   //mark: save initial link
  //   String initialUrl = await FacebookDeeplinks().getInitialUrl();
  //   final params = (initialUrl != null && initialUrl.length > 0)
  //       ? initialUrl.split("?")[1]
  //       : initialUrl;
  //   if (params != null &&
  //       params.length > 0 &&
  //       await sharedPreferenceManager.getDeepLinkData() != null)
  //     sharedPreferenceManager.saveDeepLinkData(params);
  //   //developer.log('fb deeplink initialUrl = $params');
  //   //developer.log('fb deeplink from local storage = ${await sharedPreferenceManager.getDeepLinkData()}');
  // }

  // generateFinalLink(String siteUrl) async {
  //   String platform = Platform.isAndroid ? "android" : "ios";
  //   //
  //   String additionalParams =
  //       await sharedPreferenceManager.getDeepLinkData() ?? '';
  //   //
  //   additionalParams = additionalParams == null || additionalParams.length < 1
  //       ? ''
  //       : additionalParams + '&';
  //   //
  //   final appendDeeplink = siteUrl.contains("?") ? '&' : '?';
  //   var link =
  //       '${siteUrl}${appendDeeplink}${additionalParams}platform=${platform}';

  //   if (!(await canLaunch(link))) {
  //     link = siteUrl;
  //   }
  //   return link;
  // }

  Future<bool> updateViewCount({required FirebaseNews firebaseNews}) async {
    //developer.log((await _sharedPreferenceManager.isViewedNews(firebaseNews.key)).toString());

    // if (!await sharedPreferenceManager.isViewedNews(firebaseNews.key!)) {
    //   sharedPreferenceManager.setViewedNews(firebaseNews.key!);
    //   ++firebaseNews.articleClicked;
    //   if (Platform.isAndroid) {
    //     ++firebaseNews.articleClickedAndroid;
    //   } else {
    //     ++firebaseNews.articleClickedIOS;
    //   }

    //   // await firebaseManager.updateFirebaseNews(firebaseNews: firebaseNews);
    // }

    return true;
  }

  Future updateLinkViewCount({required FirebaseNews firebaseNews}) async {
    if (!await sharedPreferenceManager.isViewedLink(firebaseNews.key!)) {
      await sharedPreferenceManager.setViewedLink(firebaseNews.key!);

      // ++firebaseNews.webViewClicked;
      // //mark: update firebase news clicked by platform
      // if (Platform.isAndroid) {
      //   ++firebaseNews.webViewClickedAndroid;
      // } else {
      //   ++firebaseNews.webViewClickedIOS;
      // }

      // await firebaseManager.updateFirebaseNews(firebaseNews: firebaseNews);
    }
  }
}
