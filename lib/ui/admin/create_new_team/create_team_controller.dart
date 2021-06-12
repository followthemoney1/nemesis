import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sport_news/data/local/local_team.dart';
import 'package:sport_news/data/network_new/game_category.dart';

import 'package:sport_news/managers/firebase_manager.dart';

class CreateTeamController extends GetxController {
  FirebaseManager firebaseManager = Get.find<FirebaseManager>();
  CreateTeamController();

  GameCategory? _gameCategory;
  set gameCategory(GameCategory? c) {
    _gameCategory = c;
    createTeam.gameCategory = c;
    update();
    loadTeams();
  }

  GameCategory? get gameCategory => _gameCategory;

  LocalTeam? selectedTeam;
  LocalTeam createTeam = LocalTeam();

  List<LocalTeam> _teams = <LocalTeam>[].obs;
  List<LocalTeam> get teams => _teams;
  set teams(List<LocalTeam> c) {
    _teams.clear();
    _teams.addAll(c);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  selectTeam(LocalTeam? c) {
    selectedTeam = c;
    log('team selected = ${selectedTeam!.name}');
    update();
  }

  loadTeams() async {
    if (gameCategory != null) {
      teams = await firebaseManager.getTeamsByCategory(
          gameCategoryId: gameCategory!.snapshotID!);
      log(teams.length.toString());
      update();
    } else {
      showToast("Game category null");
    }
  }

  addNewTeam() async {
    if (!createTeam.isBlank! && !createTeam.checkIfAnyIsNull()) {
      await firebaseManager.addNewTeam(team: createTeam);
      showToast("added teamName.value ${selectedTeam!.name}");
    } else {
      showToast("teamName.value is empty");
    }
  }
}
