import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/network_new/local_user.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/user_manager.dart';

enum LoggedState { loggin, undefine }

class HeaderController extends GetxController {
  FirebaseManager firebaseManager;
  UserManager userManager;
  HeaderController({required this.firebaseManager, required this.userManager});

  LoggedState loginState = LoggedState.undefine;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await checkLoginState();
  }

  checkLoginState() async {
    firebaseManager.subscribeToLogginState().asBroadcastStream().listen((user) async{
      print('handle login = $user');
      if (user != null) {
        loginState = LoggedState.loggin;
        LocalUser localUser = await userManager.getUserData(user);
      } else {
        loginState = LoggedState.undefine;
      }

      update();
    });
  }
}
