import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:sport_news/data/local/local_team.dart';
import 'package:sport_news/data/network/categories.dart';
import 'package:sport_news/data/network/firebase_languages.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/data/network/group_news.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:sport_news/data/network_new/game_category.dart';
import 'package:sport_news/data/network_new/match_event.dart';

final GAME_CATEGORY = 'all_game_categoryes';
final ALL_TEAMS = 'all_teams';
final MATCHES = "all_matches";

class FirebaseManager {
  FirebaseFirestore database = FirebaseFirestore.instance;

  String currentLanguage;
  FirebaseLanguages langKey;
  List<FirebaseGroupNews> newData;

  Future init() async {
    await Firebase.initializeApp();

    if (currentLanguage == null) {
      String defaultSystemLocale = 'en_US'; //Platform.localeName;
      currentLanguage = defaultSystemLocale.split('_')[0];
      //developer.log(currentLanguage);
    }
    // if (langKey == null) langKey = await getFirebaseLangKeyByLang();
    // if (newData == null) newData = await getNewsGroupsWithReturn();
  }

//MARK: match
  createMatch(MatchEvent match) async {
    await database.collection(MATCHES).add(match.toMap());
  }

  Future<List<MatchEvent>> getMatches() async{
    final doc = await database.collection(MATCHES).get();
    final matches = doc.docs.map((snapshot) {
      return MatchEvent.fromSnapshot(snapshot);
    }).toList();

    return matches;
  }

//MARK: teams
  Future<List<LocalTeam>> getTeams() async {
    final doc = await database.collection(ALL_TEAMS).get();
    final teams = doc.docs.map((snapshot) {
      return LocalTeam.fromSnapshot(snapshot);
    }).toList();

    return teams;
  }

  addNewTeam(LocalTeam team) async {
    await database.collection(ALL_TEAMS).add(team.toMap());
  }

//MARK: category

  Future<List<GameCategory>> getGameCategoryes() async {
    final doc = await database.collection(GAME_CATEGORY).get();
    final categoryes = doc.docs.map((snapshot) {
      return GameCategory.fromSnapshot(snapshot);
    }).toList();

    return categoryes;
  }

  addNewCategory(String category) async {
    await database.collection(GAME_CATEGORY).add(
        {"name": category, "id": category.toLowerCase().replaceAll(" ", "_")});
  }
}
