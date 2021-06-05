import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/local/local_team.dart';
import 'package:sport_news/data/network_new/game_category.dart';

import 'package:sport_news/managers/firebase_manager.dart';

class CreateTeamController extends GetxController {
  FirebaseManager firebaseManager;
  final String tag;
  CreateTeamController(this.firebaseManager, {this.tag});

  LocalTeam selectedTeam = LocalTeam();
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

  selectTeam(LocalTeam c) {
    selectedTeam = c;
    update();
  }

  loadTeams() async {
    teams = await firebaseManager.getTeams();
    selectedTeam = teams.first;
    print(teams.length);
    update();
  }

  addNewTeam() async {
    if (!createTeam.isBlank) {
      await firebaseManager.addNewTeam(team:createTeam);
      Get.snackbar("Added", "teamName.value ${selectedTeam.name}");
    } else {
      Get.snackbar("Error", "teamName.value is empty");
    }
  }
}
