import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/data/network_new/league.dart';
import 'package:sport_news/managers/firebase_manager.dart';

class CreateLeagueController extends GetxController {
  FirebaseManager firebaseManager = Get.find<FirebaseManager>();
  League? selectedLeague;
  League createLeague = League();

 List<League> _leagues = <League>[].obs;
  List<League> get leagues  => _leagues;
  set leagues (List<League> c) {
    _leagues.clear();
    _leagues.addAll(c);
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadLeague();
  }

  loadLeague() async {
    leagues = await firebaseManager.getLeagues();    
    update();
  }

  addNewLeague() async {
    if (!createLeague.isBlank!) {
      await firebaseManager.addNewLeague(league: createLeague);
      Get.showSnackbar(GetBar(
          title: "Added", message: "createLeague.value ${createLeague!.name}"));
    } else {
      Get.showSnackbar(
          GetBar(title: "Error", message: "createLeague.value is empty"));
    }
  }
}
