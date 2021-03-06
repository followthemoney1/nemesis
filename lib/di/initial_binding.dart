import 'package:get/get.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/network_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';
import 'package:sport_news/managers/user_manager.dart';
import 'package:sport_news/ui/admin/create_category/create_category_controller.dart';
import 'package:sport_news/ui/admin/create_new_team/create_team_controller.dart';
import 'package:sport_news/ui/header/header_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NetworkManager>(NetworkManager());
    Get.put<FirebaseManager>(FirebaseManager()..init());
    Get.put<SharedPreferenceManager>(SharedPreferenceManager()..init());
    Get.put<UserManager>(
        UserManager(firebaseManager: Get.find<FirebaseManager>()));
    Get.put<HeaderController>(
        HeaderController(firebaseManager: Get.find(), userManager: Get.find()));
  }
}
