import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/firebase_manager.dart';

class MatchesListController extends GetxController {
  FirebaseManager firebaseManager = Get.find<FirebaseManager>();
  String tag;
  MatchesListController({required this.tag});

  List<MatchEvent> matches = [];

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getMatches();
  }

  getMatches() async {
    final s =  firebaseManager.getMatchesByCategoryStream(categoryId: tag);
    s.forEach((element) {
      final matches = element.docs.map((snapshot) {
        return MatchEvent.fromSnapshot(snapshot);
      }).toList();

      this.matches.clear();
      this.matches.addAll(matches);
      update();
    });
    // update();
  }
}
