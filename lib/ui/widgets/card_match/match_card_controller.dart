import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/local/local_team.dart';
import 'package:sport_news/data/network_new/league.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/firebase_manager.dart';

class MatchCardController extends GetxController {
  static FirebaseManager firebaseManager = Get.find<FirebaseManager>();
  MatchEvent match;
  String tag;
  MatchCardController({required this.match, required this.tag});

  bool _hoverItem = false;
  set hoverItem(bool h) {
    this._hoverItem = h;
    update();
  }

  bool get hoverItem => _hoverItem;

  LocalTeam? team1;
  LocalTeam? team2;
  League? league;

  Isolate? _isolate;
  late ReceivePort _receivePort;
  @override
  void onInit() async {
    super.onInit();
    log('spawn isolate');
    spawnIsolate();
    // getMatchData(match).then((res) {
    //   team1 = res.team1;
    //   team2 = res.team2;
    //   if (res.league != null) {
    //     league = res.league;
    //   }
    //   update();
    // });
  }

  spawnIsolate() {
    compute(([dynamic _]) => downloadDataIsolate(match), '_handleMessage')
        .then((res) => _handleMessage(res));
    // log('spawn isolate');
    // _receivePort = ReceivePort();
    // _isolate = await Isolate.spawn(downloadDataIsolate, _receivePort.sendPort);
    // _receivePort.listen(_handleMessage, onDone: () {
    //   print("done!");
    //   _stop();
    // });
  }

  void _handleMessage(dynamic data) {
    final res = data as RecivePortData;
    print('RECEIVED: ' + data.team1!.name!);
    team1 = res.team1;
    team2 = res.team2;
    if (res.league != null) {
      league = res.league;
    }

    update();
    _stop();
  }

  void _stop() {
    if (_isolate != null) {
      _receivePort.close();
      _isolate!.kill(priority: Isolate.immediate);
      _isolate = null;
    }
  }

  static Future<RecivePortData> downloadDataIsolate(MatchEvent match) async {
    final res = await getMatchData(match);
    return res;
  }

  static Future<RecivePortData> getMatchData(MatchEvent match) async {
    log('get match data');
    final res = RecivePortData();
    // final firebaseManager = Get.find<FirebaseManager>();
    LocalTeam team1 =
        await firebaseManager.getTeamById(teamId: match.team1!.snapshotId!);
    LocalTeam team2 =
        await firebaseManager.getTeamById(teamId: match.team2!.snapshotId!);
    if (match.leagueId != null) {
      League league =
          await firebaseManager.getLeagueById(leagueId: match.leagueId!);
      res.league = league;
      log(league!.imageUrl!);
    }
    res.team1 = team1;
    res.team2 = team2;

    return res;
  }
}

class RecivePortData {
  LocalTeam? team1;
  LocalTeam? team2;
  League? league;
}
