import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/local/local_team.dart';
import 'package:sport_news/data/network_new/league.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/firebase_manager.dart';

class MatchDetailController extends GetxController {
  FirebaseManager firebaseManager = Get.find<FirebaseManager>();

  MatchEvent? match;
  String? matchId;
  LocalTeam? team1;
  LocalTeam? team2;
  League? league;


  @override
  void onInit() async {
    await getArgs();
    super.onInit();
  }

  getArgs() async {
    matchId = Get.parameters['matchId'];
    if (matchId == null) {
      //mark; show error
      return;
    }

    match = await firebaseManager.getMatchesById(matchId: matchId!);
    if(match==null){
      //mark: show error
      return;
    }

    update();

    await getMatchData();
  }

   getMatchData() async {
    team1 =
        await firebaseManager.getTeamById(teamId: match!.team1!.snapshotId!);
    team2 =
        await firebaseManager.getTeamById(teamId: match!.team2!.snapshotId!);
    if (match!.leagueId != null) {
      league = await firebaseManager.getLeagueById(leagueId: match!.leagueId!);
      log(league!.imageUrl!);
    }
    update();
  }
}
