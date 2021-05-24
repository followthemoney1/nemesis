import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/local/local_team.dart';
import 'package:sport_news/data/network_new/game_category.dart';

import 'package:sport_news/managers/firebase_manager.dart';

class CreateTeamController extends GetxController {
  FirebaseManager firebaseManager;

  CreateTeamController(this.firebaseManager);

  LocalTeam team = LocalTeam();

  @override
  Future<void> onInit() async {
    super.onInit();
  
  }


  void publish(){
  }
}
