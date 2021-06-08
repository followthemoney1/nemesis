
import 'dart:developer';

import 'package:get/get.dart';
import 'package:sport_news/ui/admin/create_category/create_category_controller.dart';
import 'package:sport_news/ui/news_list/news_list_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    // final c = CreateCategoryController(
    //     firebaseManager: Get.find(), tag: Random().nextInt(400).toString());
    // Get.create<CreateCategoryController>(() => c);
    // Get.put<CreateCategoryController>(c, tag: c.tag);
    // Get.create<CreateTeamController>(() => CreateTeamController(Get.find()));
    Get.lazyPut(() => MatchesListController(firebaseManager: Get.find()));
    log("root binding");
  }
}
