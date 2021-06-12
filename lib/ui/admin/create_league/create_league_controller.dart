import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sport_news/data/network_new/league.dart';
import 'package:sport_news/managers/firebase_manager.dart';

class CreateLeagueController extends GetxController {
  FirebaseManager firebaseManager = Get.find<FirebaseManager>();

  League? _selectedLeague;
  set selectedLeague(League? l) {
    _selectedLeague = l;
    update();
  }
  League? get selectedLeague => _selectedLeague;

  League createLeague = League();

  List<League> leagues = <League>[].obs;
 

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
      showToast("added createLeague.value ${createLeague.name}");
    } else {
      showToast("createLeague.value is empty");
    }
  }
}
