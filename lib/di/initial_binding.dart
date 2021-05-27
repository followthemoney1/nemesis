import 'package:get/get.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';
import 'package:sport_news/ui/admin/create_category/create_category_controller.dart';
import 'package:sport_news/ui/admin/create_new_team/create_team_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FirebaseManager>(FirebaseManager()..init());
    Get.put<SharedPreferenceManager>(SharedPreferenceManager()..init());

    // Get.create<CreateCategoryController>(() => CreateCategoryController(Get.find()));
    // Get.create<CreateTeamController>(() => CreateTeamController(Get.find()));

  }
}
