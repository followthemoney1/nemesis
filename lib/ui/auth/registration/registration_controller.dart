import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/user_manager.dart';

class RegistrationController extends GetxController with SingleGetTickerProviderMixin {
  FirebaseManager firebaseManager;
  UserManager userManager;
  RegistrationController({required this.firebaseManager, required this.userManager});

  AnimationController? animationController;
  late Animation animation;

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
    ).animate(animationController!)
      ..addListener(() {
        if (animationController!.isCompleted) {}
      });

    update();

    Future.delayed(const Duration(milliseconds: 400), () {
      animationController!..forward();
    });
  }

  @override
  void onInit() {
    initAnimation();
    super.onInit();
  }

  createUser() async {
    if (!formKey.currentState!.validate() ||
        user.email.isEmpty ||
        user.password!.isEmpty ||
        user.nickName!.isEmpty) {
      Get.snackbar(
          'Some field isn\'t correct', "Please fill all fields in correct way");
      return;
    }

    final result = await firebaseManager.createUserWithEmailAndPassword(
        email:user.email, password:user.password!);
    if (result.a.isEmpty && result.b!=null) {
      await userManager.updateFirstCreateUser(result.b!,nickName: user.nickName);
      Get.back();
    } else {
      Get.snackbar('Registration Error', result.a);
    }
  }

  Future<void> googleSignIn() async {
    try {
      final userCred = await firebaseManager.signInWithGoogle();
      await checkProfile(userCred!);
    } on FirebaseException catch (e) {}
  }

  Future<void> checkProfile(UserCredential userCred) async {
    if (userCred == null || userCred.user == null) {
      return;
    }
  }
}

class UserRegistration {
  late String email;
  String? password;
  String? nickName;
}
