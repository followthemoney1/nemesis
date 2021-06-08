import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';

class HomeController extends GetxController {
  SharedPreferenceManager sharedPreferenceManager =
      Get.find<SharedPreferenceManager>();

  int _selectedMenuPage = 0;
  set selectedMenuPage(int index) {
    _selectedMenuPage = index;
    update();
    sharedPreferenceManager.setectMenuItem(index);
  }

  int get selectedMenuPage => _selectedMenuPage;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    _getSelectedMenuItem();
  }

  _getSelectedMenuItem() async {
    final selected = await sharedPreferenceManager.getSelectedMenuItem();
    if (selected != null) {
      selectedMenuPage = selected;
    }
  }
}
