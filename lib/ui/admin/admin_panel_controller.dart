import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sport_news/data/network_new/game_category.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/firebase_manager.dart';

import 'create_new_team/create_team_controller.dart';

class AdminPanelController extends GetxController {
  FirebaseManager? firebase = Get.find<FirebaseManager>();

  AdminPanelController();
  MatchEvent match = MatchEvent();
  Rx<DateTime> startTime = DateTime.now().obs;
  String? selectedLeagueId;

  GameCategory? _selectedGameCategory;
  set selectedGameCategory(GameCategory? c) {
    _selectedGameCategory = c;
    update();
  }

  GameCategory? get selectedGameCategory => _selectedGameCategory;

  @override
  void onInit() {
    super.onInit();
  }

  createMatch(
    CreateTeamController firstTeam,
    CreateTeamController secondTeam,
  ) async {
    log("first team : ${firstTeam.selectedTeam!.name} vs second team: ${secondTeam.selectedTeam!.name}");
    match
      ..team1 = firstTeam.selectedTeam
      ..team2 = secondTeam.selectedTeam
      ..schedule = startTime.value
      ..matchStreamUrl = 'fff'
      ..leagueId = selectedLeagueId
      ..categoryId = selectedGameCategory!.snapshotID
      ..bo = 1;

    if (!match.checkIfAnyIsNull()) {
      await firebase!.createMatch(match: match);
      showToast(
            'Match with teams ::::first team : ${firstTeam.selectedTeam!.name} vs second team: ${secondTeam.selectedTeam!.name}:::: was created',
      );
    } else {
     showToast('Some field is null ' + match.toMap().toString(),
      );
    }
  }

  // setStartTime(DateTime t){
  //   this.startTime = t;
  //   update();
  // }
}
