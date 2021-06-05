import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/managers/firebase_manager.dart';

class LoginController extends GetxController with SingleGetTickerProviderMixin {
  FirebaseManager firebaseManager;
  LoginController({@required this.firebaseManager});

  AnimationController animationController;
  Animation animation;

  UserRegistration user = UserRegistration();
  GlobalKey<FormState> formKey = GlobalKey();

  void initAnimation() {
    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    animation = ColorTween(
      begin: Colors.black.withOpacity(0),
      end: Colors.black.withOpacity(0.6),
    ).animate(animationController)
      ..addListener(() {
        if (animationController.isCompleted) {}
      });

    update();

    Future.delayed(const Duration(milliseconds: 400), () {
      animationController..forward();
    });
  }

  @override
  void onInit() {
    initAnimation();
    super.onInit();
  }

  loginUser() async {
    if (!formKey.currentState.validate() ||
        user.email.isEmpty ||
        user.password.isEmpty) {
      Get.snackbar(
          'Some field isn\'t correct', "Please fill all fields in correct way");
      return;
    }

    final result = await firebaseManager.signInWithEmailAndPassword(
        email:user.email, password:user.password);
    if (result.isEmpty) {
      Get.back();
    } else {
      Get.snackbar('Login Error', result);
    }
  }

  Future<void> googleSignIn() async {
    try {
      final userCred = await firebaseManager.signInWithGoogle();
      await checkProfile(userCred);
    } on FirebaseException catch (e) {}
  }

  Future<void> checkProfile(UserCredential userCred) async {
    if (userCred == null || userCred.user == null) {
      return;
    }
  }
}

class UserRegistration {
  String email;
  String password;
  String nickName;
}
