import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sport_news/data/helper/pair.dart';
import 'package:sport_news/data/local/local_team.dart';
import 'package:sport_news/data/network/categories.dart';
import 'package:sport_news/data/network/firebase_languages.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/data/network/group_news.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:sport_news/data/network_new/chat_message.dart';
import 'package:sport_news/data/network_new/game_category.dart';
import 'package:sport_news/data/network_new/league.dart';
import 'package:sport_news/data/network_new/local_user.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:firebase/firebase.dart' as core;
import 'package:sport_news/pr_extension.dart';

import 'dart:html' as html;

import 'network_manager.dart';

final GAME_CATEGORY = 'all_game_categoryes';
final ALL_TEAMS = 'all_teams';
final ALL_LEAGUE = 'all_league';
final MATCHES = "all_matches";
final USERS = "all_users";
final CHATS = "all_chats";

class FirebaseManager {
  NetworkManager networkManager = Get.find<NetworkManager>();
  FirebaseFirestore database = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  // FirebaseFunctions functions =
  //     FirebaseFunctions.instanceFor(region: 'us-central1');

  core.Storage storage = core.storage();

  String? currentLanguage;
  FirebaseLanguages? langKey;
  List<FirebaseGroupNews>? newData;

  Future init() async {
    await Firebase.initializeApp();

    if (currentLanguage == null) {
      String defaultSystemLocale = 'en_US'; //Platform.localeName;
      currentLanguage = defaultSystemLocale.split('_')[0];
    }

    FirebaseFirestore.instance.settings =
        Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    await FirebaseFirestore.instance.enablePersistence();

    // functions.useFunctionsEmulator(origin: 'http://localhost:5001');
  }

  //registration
  Future<UserCredential?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn(
            // hostedDomain: "http://localhost",
            clientId:
                "151991726103-n2b1id464ohqdqjgtmrgeimpd92ierbr.apps.googleusercontent.com")
        .signIn();

    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      // log(googleUser.toString());

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await auth.signInWithCredential(credential);
    }
    return null;
  }

  Future<Pair<String, User?>> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return Pair('', userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        return Pair('weak-password', null);
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        return Pair('email-already-in-use', null);
      }
    } catch (e) {
      log(e.toString());
      return Pair(e.toString(), null);
    }
    return Pair('', null);
  }

//login
  Future<String> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return '';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        return 'user-not-found';
      } else if (e.code == 'user-not-found') {
        log("Wrong password provided for that user.");
        return 'user-not-found';
      }
    } catch (e) {
      return e.toString();
    }
    return '';
  }

  Future<User?> checkLoginState() async {
    return auth.currentUser;
  }

  Stream<User?> subscribeToLogginState() {
    return auth.authStateChanges();
  }

//mark: users data
  updateUserData({required LocalUser user}) async {
    await database.collection(USERS).add(user.toMap());
  }

  Future<LocalUser> getUserDataByID({String? id}) async {
    final doc = await database.collection(USERS).doc(id).get();
    final users = LocalUser.fromSnapshot(doc);

    return users;
  }

  Future<bool> updateUserDataByID({String? id, required LocalUser user}) async {
    developer.log('user id updating with $id');
    final res = await database.collection(USERS).doc(id).set(user.toMap());
    return true;
  }

  // Future<bool> createUserDataByID({String id, LocalUser user})async{
  //   database.collection(USERS).add(id);
  //   await database.collection(USERS).doc(id).update(user.toMap());
  // }

//MARK: match
  createMatch({required MatchEvent match}) async {
    await database.collection(MATCHES).add(match.toMap());
  }

  Future<List<MatchEvent>> getAllMatches() async {
    final doc = await database.collection(MATCHES).get();
    final matches = doc.docs.map((snapshot) {
      return MatchEvent.fromSnapshot(snapshot);
    }).toList();

    return matches;
  }

  Future<List<MatchEvent>> getMatchesByCategory(
      {required String categoryId}) async {
    final doc = await database
        .collection(MATCHES)
        .where('category_id', isEqualTo: categoryId)
        .get();
    final matches = doc.docs.map((snapshot) {
      return MatchEvent.fromSnapshot(snapshot);
    }).toList();

    return matches;
  }

  Stream<QuerySnapshot> getMatchesByCategoryStream(
      {required String categoryId})  {
    return  database
        .collection(MATCHES)
        .where('category_id', isEqualTo: categoryId)
        .snapshots().asBroadcastStream();
   
  }

  Future<MatchEvent> getMatchesById({required String matchId}) async {
    final snapshot = await database.collection(MATCHES).doc(matchId).get();
    final match = MatchEvent.fromSnapshot(snapshot);
    return match;
  }

  updateMatchById({required MatchEvent match}) async {
    await database
        .collection(MATCHES)
        .doc(match.snapshotId)
        .update(match.toMap());
  }

//MARK: leagues
  Future<List<League>> getLeagues() async {
    final doc = await database.collection(ALL_LEAGUE).get();
    final leagues = doc.docs.map((snapshot) {
      return League.fromSnapshot(snapshot);
    }).toList();

    return leagues;
  }

  addNewLeague({required League league}) async {
    await database.collection(ALL_LEAGUE).add(league.toMap());
  }

  Future<League> getLeagueById({required String leagueId}) async {
    final snapshot = await database.collection(ALL_LEAGUE).doc(leagueId).get();
    final league = League.fromSnapshot(snapshot);
    return league;
  }

//MARK: teams
  Future<List<LocalTeam>> getTeams() async {
    final doc = await database.collection(ALL_TEAMS).get();
    final teams = doc.docs.map((snapshot) {
      return LocalTeam.fromSnapshot(snapshot);
    }).toList();

    return teams;
  }

  Future<List<LocalTeam>> getTeamsByCategory(
      {required String gameCategoryId}) async {
    final doc = await database
        .collection(ALL_TEAMS)
        .where("game_category_id", isEqualTo: gameCategoryId)
        .get();
    final teams = doc.docs.map((snapshot) {
      return LocalTeam.fromSnapshot(snapshot);
    }).toList();

    return teams;
  }

  addNewTeam({required LocalTeam team}) async {
    await database.collection(ALL_TEAMS).add(team.toMap());
  }

  Future<LocalTeam> getTeamById({required String teamId}) async {
    final snapshot = await database.collection(ALL_TEAMS).doc(teamId).get();
    final team = LocalTeam.fromSnapshot(snapshot);
    return team;
  }
//MARK: category

  Future<List<GameCategory>> getGameCategoryes() async {
    final doc = await database.collection(GAME_CATEGORY).get();
    final categoryes = doc.docs.map((snapshot) {
      return GameCategory.fromSnapshot(snapshot);
    }).toList();

    return categoryes;
  }

  addNewCategory({required String category}) async {
    await database.collection(GAME_CATEGORY).add(
        {"name": category, "id": category.toLowerCase().replaceAll(" ", "_")});
  }

  Future<String> uploadImage(
      {required String folder, required html.File file}) async {
    // final meta = core.UploadMetadata(contentEncoding: "image/png");

    final task = storage.ref().child(folder).child(file.name).put(file);

    final res = await task.future;

    return (await res.ref.getDownloadURL()).normalizePath().toString();
  }

  //subscribe to chat
  Stream<QuerySnapshot<Map>> subscribeToChat({
    required matchId,
  }) {
    return database
        .collection(CHATS)
        .doc(matchId)
        .collection(matchId)
        .orderBy('timestamp', descending: true)
        // .limit(limit)
        .snapshots();
  }

  sendMessage({required matchId, required ChatMessage message}) async {
    var documentReference = database
        .collection(CHATS)
        .doc(matchId)
        .collection(matchId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    database.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        message.toMap(),
      );
    });

    return '';
  }

  //functions
  // placeABet(
  //     {required String userId,
  //     required double place,
  //     required String matchId,
  //     required String onTeamId}) async {
  //   await networkManager.placeABet(userId: userId, place: place.toString(), matchId: matchId,onTeamId: onTeamId);
  //   // final callable = functions.httpsCallable('placeABet');
  //   // final result = await callable
  //   //     .call({'userId': userId, "place": place, "onTeamId": onTeamId});

  //   // print(result);
  // }
}
