import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/local/local_team.dart';
import 'package:sport_news/data/network_new/league.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/firebase_manager.dart';

class MatchCardController extends GetxController {
  FirebaseManager firebaseManager = Get.find<FirebaseManager>();
  MatchEvent match;
  String tag;
  MatchCardController({required this.match, required this.tag});

  bool _hoverItem = false;
  set hoverItem(bool h){
    this._hoverItem = h;
    update();
  }
  bool get hoverItem => _hoverItem;

  LocalTeam? team1;
  LocalTeam? team2;
  League? league;
  @override
  void onInit() {
    super.onInit();
    getMatchData();
  }

  getMatchData() async {
    team1 =
        await firebaseManager.getTeamById(teamId: match!.team1!.snapshotId!);
    team2 =
        await firebaseManager.getTeamById(teamId: match!.team2!.snapshotId!);
    if (match.leagueId != null) {
      league = await firebaseManager.getLeagueById(leagueId: match!.leagueId!);
      log(league!.imageUrl!);
    }
    update();
  }
}
