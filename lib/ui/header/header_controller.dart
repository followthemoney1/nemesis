import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/managers/firebase_manager.dart';

enum LoggedState { loggin, undefine }

class HeaderController extends GetxController {
  FirebaseManager firebaseManager;
  HeaderController({@required this.firebaseManager});

  LoggedState loginState = LoggedState.undefine;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await checkLoginState();
  }

  checkLoginState() async {
    firebaseManager.subscribeToLogginState().asBroadcastStream().listen((user) {
      print('handle login = $user');
      if (user != null) {
        loginState = LoggedState.loggin;
      } else {
        loginState = LoggedState.undefine;
      }

      update();
    });
  }
}
