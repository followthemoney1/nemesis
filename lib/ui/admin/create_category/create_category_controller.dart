import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sport_news/data/network_new/game_category.dart';
import 'package:sport_news/managers/firebase_manager.dart';

class CreateCategoryController extends GetxController {
  FirebaseManager firebaseManager;

  CreateCategoryController({this.firebaseManager});

  TextEditingController teamName = TextEditingController();

  GameCategory chosenCategory;

  List<GameCategory> _categoryes = <GameCategory>[].obs;
  List<GameCategory> get categoryes => _categoryes;
  set categoryes(List<GameCategory> c) {
    _categoryes.clear();
    _categoryes.addAll(c);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadCategory();
  }

  selectCategory(GameCategory c) {
    chosenCategory = c;
    update();
  }

  loadCategory() async {
    categoryes = await firebaseManager.getGameCategoryes();
    // chosenCategory = categoryes.first;
    print(categoryes.length);
    update();
  }

  addCategory() async {
    if (!teamName.text.isEmpty) {
      await firebaseManager.addNewCategory(teamName.text);
      Get.snackbar("Added", "teamName.value ${teamName.text}");
    } else {
      Get.snackbar("Error", "teamName.value is empty");
    }
  }
}
