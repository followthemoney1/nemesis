import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sport_news/data/local/local_team.dart';
import 'package:sport_news/data/network_new/league.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/network_manager.dart';
import 'package:sport_news/ui/widgets/animated_elevation_card.dart';

class MatchDetailController extends GetxController
    with SingleGetTickerProviderMixin {
  FirebaseManager firebaseManager = Get.find<FirebaseManager>();
  League? league;
  MatchEvent? match;
  String? matchId;
  NetworkManager networkManager = Get.find<NetworkManager>();
  TextEditingController placeCountC = TextEditingController();
  LocalTeam? selectedTeam;
  LocalTeam? team1;
  LocalTeam? team2;

  // AnimatedElevationCardController team1controller = Get.put<AnimatedElevationCardController>(AnimatedElevationCardController('team1'),tag: 'team1');
  bool _onTeam1Select = false;

  // AnimatedElevationCardController team2controller = Get.put<AnimatedElevationCardController>(AnimatedElevationCardController('team2'),tag: 'team2');
  bool _onTeam2Select = false;

  @override
  void onInit() async {
    await getArgs();
    super.onInit();
  }

  set onTeam1Select(bool select1Team) {
    _onTeam1Select = select1Team;
    // team1controller.updateAnim(selected:_onTeam1Select);
    if (onTeam2Select && select1Team) {
      onTeam2Select = false;
    }
    if (select1Team) {
      selectedTeam = team1;
    } else {
      selectedTeam = null;
    }
    update();
  }

  bool get onTeam1Select => _onTeam1Select;

  set onTeam2Select(bool select2Team) {
    _onTeam2Select = select2Team;
    // team2controller.updateAnim(selected:_onTeam2Select);
    log(select2Team.toString());
    if (onTeam1Select && select2Team) {
      onTeam1Select = false;
    }
    if (select2Team) {
      selectedTeam = team2;
    } else {
      selectedTeam = null;
    }
    update();
  }

  bool get onTeam2Select => _onTeam2Select;

  getArgs() async {
    matchId = Get.parameters['matchId'];
    if (matchId == null) {
      //mark; show error
      return;
    }

    match = await firebaseManager.getMatchesById(matchId: matchId!);
    if (match == null) {
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

  placeBet() async {
    if (selectedTeam == null ||
        placeCountC.text.isEmpty ||
        selectedTeam == null ||
        selectedTeam!.snapshotId! == null ||
        firebaseManager.auth.currentUser == null ||
        firebaseManager.auth.currentUser!.uid == null) {
      showToast("Can't place a bet. Maybe you didn't login or select a team.");
      return;
    }
    final response = await networkManager.placeABet(
        onTeamId: selectedTeam!.snapshotId!,
        place: placeCountC.text,
        matchId: matchId!,
        userId: firebaseManager.auth.currentUser!.uid);
    if (response.success!) {
      showToast('Placed ${response.placed} was successful');
      // Get.showSnackbar(GetBar(
      //     title: 'Placed success on a Team',
      //     message: 'Placed ${response.placed} was successful'));
    } else {
      showToast('Error: ${response.error}');
      // Get.showSnackbar(GetBar(
      //     title: 'Placed on a Team had an error',
      //     message: 'Error: ${response.error}'));
    }

    getArgs();
  }
}
