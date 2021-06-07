import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/local/local_team.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/firebase_manager.dart';

class MatchCardController extends GetxController {
  FirebaseManager firebaseManager = Get.find<FirebaseManager>();
  MatchEvent match;
  String tag;
  MatchCardController({required this.match, required this.tag});

  LocalTeam? team1;
  LocalTeam? team2;

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
    update();
  }
}
