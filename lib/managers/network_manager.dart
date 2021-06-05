import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sport_news/data/network/firebase_news.dart';
import 'dart:developer' as developer;

class NetworkManager {
  Future<List<FirebaseNews>?> getTopNewsByGroupKey(String key) async {
    var url =
        'https://us-central1-sportnews-8bbab.cloudfunctions.net/getTopNews';
    var response = await http.post(Uri.parse(url), body: {"group_key": "$key"});
    //developer.log('response top news = ${response.toString()}');
    if (response.statusCode == 200) {
      Map f = json.decode(response.body);
      List<FirebaseNews> frbNews = [];
      for (var e in f.entries) {
        frbNews.add(FirebaseNews.fromMap(snapshot: e.value, k: e.key));
      }

      return frbNews;
    } else
      return null;
  }
}
