import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sport_news/data/network_new/game_category.dart';
import 'package:sport_news/managers/firebase_manager.dart';

class CreateCategoryController extends GetxController {
  FirebaseManager firebaseManager = Get.find<FirebaseManager>();

  CreateCategoryController();

  TextEditingController categoryName = TextEditingController();

  GameCategory? chosenCategory;

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

  selectCategory(GameCategory? c) {
    chosenCategory = c;
    update();
  }

  loadCategory() async {
    categoryes = await firebaseManager.getGameCategoryes();
    log(categoryes.length);
    update();
  }

  addCategory() async {
    if (!categoryName.text.isEmpty) {
      await firebaseManager.addNewCategory(category: categoryName.text);
     showToast("added teamName.value ${categoryName.text}");
    } else {
      showToast("teamName.value is empty");
    }
  }
}
