import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sport_news/data/network/firebase_news.dart';
import 'dart:developer' as developer;

import 'package:sport_news/data/network_new/place_bet_response.dart';

class NetworkManager {
  Future<PlaceNetworkResponse> placeABet({required String userId,
      required String place,
      required String matchId,
      required String onTeamId}) async {
    var url =
        'https://us-central1-nemesis-b1957.cloudfunctions.net/placeABet';
    //  var url =
        // 'http://localhost:5001/nemesis-b1957/us-central1/placeABet';
    var response = await http.post(Uri.parse(url), body: {'userId': userId, "place": place, "matchId":matchId,"onTeamId": onTeamId});
    final decodedResponse = json.decode(response.body);
    developer.log('response top news = ${decodedResponse.toString()}');

    return PlaceNetworkResponse.fromMap(decodedResponse);
  }
}
