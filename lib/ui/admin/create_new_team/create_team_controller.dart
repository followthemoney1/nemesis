import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/local/local_team.dart';
import 'package:sport_news/data/network_new/game_category.dart';

import 'package:sport_news/managers/firebase_manager.dart';

class CreateTeamController extends GetxController {
  FirebaseManager firebaseManager;
  CreateTeamController(this.firebaseManager, );

  LocalTeam? selectedTeam = LocalTeam();
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
    await loadTeams();
  }

  selectTeam(LocalTeam? c) {
    selectedTeam = c;
    log('team selected = ${selectedTeam!.name}');
    update();
  }

  loadTeams() async {
    teams = await firebaseManager.getTeams();
    selectedTeam = teams.first;
    log(teams.length.toString());
    update();
  }

  addNewTeam() async {
    if (!createTeam.isBlank!) {
      await firebaseManager.addNewTeam(team: createTeam);
      Get.showSnackbar(GetBar(
          title: "Added", message: "teamName.value ${selectedTeam!.name}"));
    } else {
      Get.showSnackbar(
          GetBar(title: "Error", message: "teamName.value is empty"));
    }
  }
}
