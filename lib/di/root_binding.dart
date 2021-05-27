import 'dart:math';

import 'package:get/get.dart';
import 'package:sport_news/ui/admin/create_category/create_category_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    // final c = CreateCategoryController(
    //     firebaseManager: Get.find(), tag: Random().nextInt(400).toString());
    // Get.create<CreateCategoryController>(() => c);
    // Get.put<CreateCategoryController>(c, tag: c.tag);
    // Get.create<CreateTeamController>(() => CreateTeamController(Get.find()));
    print("root binding");
  }
}
