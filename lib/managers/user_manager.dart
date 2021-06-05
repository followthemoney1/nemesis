import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport_news/data/network_new/local_user.dart';
import 'package:sport_news/managers/firebase_manager.dart';

class UserManager {
  late FirebaseManager _firebaseManager;

  UserManager({required firebaseManager}) {
    this._firebaseManager = firebaseManager;
  }

  Future<LocalUser> getUserData(User currentUser) async {
    LocalUser result = await _firebaseManager.getUserDataByID(id:currentUser.uid);
    return result;
  }

  Future updateFirstCreateUser(User currentUser, {String? nickName,}) async {
    final user = LocalUser()
    ..nickName = nickName
    ..snapshotId = currentUser.uid
    ..points = 0;
    

    await _firebaseManager.updateUserDataByID(id: user.snapshotId,user:user);
  }
}
