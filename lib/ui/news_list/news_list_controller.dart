import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/firebase_manager.dart';

class MatchesListController extends GetxController {
  FirebaseManager firebaseManager;
  MatchesListController({required this.firebaseManager});

  List<MatchEvent> matches = <MatchEvent>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getMatches();
  }

  getMatches() async {
    matches = await firebaseManager.getMatches();
    update();
  }
}
