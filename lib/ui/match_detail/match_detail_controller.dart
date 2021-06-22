import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/local/local_team.dart';
import 'package:sport_news/data/network_new/league.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/ui/widgets/animated_elevation_card.dart';

class MatchDetailController extends GetxController with SingleGetTickerProviderMixin{
  FirebaseManager firebaseManager = Get.find<FirebaseManager>();

  MatchEvent? match;
  String? matchId;
  LocalTeam? team1;
  LocalTeam? team2;
  League? league;

  // AnimatedElevationCardController team1controller = Get.put<AnimatedElevationCardController>(AnimatedElevationCardController('team1'),tag: 'team1');
  bool _onTeam1Select = false;
  set onTeam1Select(bool select1Team){
    _onTeam1Select = select1Team;
    // team1controller.updateAnim(selected:_onTeam1Select);
    if(onTeam2Select&&select1Team){
      onTeam2Select = false;
    }
    update();
  }
  bool get onTeam1Select => _onTeam1Select;
   
  // AnimatedElevationCardController team2controller = Get.put<AnimatedElevationCardController>(AnimatedElevationCardController('team2'),tag: 'team2');
  bool _onTeam2Select = false;
  set onTeam2Select(bool select2Team){
    _onTeam2Select = select2Team;
    // team2controller.updateAnim(selected:_onTeam2Select);
    log(select2Team.toString());
    if(onTeam1Select&&select2Team){
      onTeam1Select = false;
    }
    update();
  }
  bool get onTeam2Select => _onTeam2Select; 

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
