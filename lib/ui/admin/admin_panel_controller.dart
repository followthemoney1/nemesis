import 'dart:html';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/firebase_manager.dart';

import 'create_new_team/create_team_controller.dart';

class AdminPanelController extends GetxController {
  FirebaseManager? firebase;

  AdminPanelController({this.firebase});
  MatchEvent match = MatchEvent();
  Rx<DateTime> startTime = DateTime.now().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  createMatch(CreateTeamController firstTeam, CreateTeamController secondTeam,) {
    print(
        "first team : ${firstTeam.selectedTeam!.name} vs second team: ${secondTeam.selectedTeam!.name}");
    match
    ..team1 = firstTeam.selectedTeam
    ..team2 = secondTeam.selectedTeam
    ..schedule = startTime.value
    ..matchStreamUrl = 'fff'
    ..bo = 1;

    firebase!.createMatch(match:match);
  }

  // setStartTime(DateTime t){
  //   this.startTime = t;
  //   update();
  // }
}
