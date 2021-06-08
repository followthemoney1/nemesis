import 'dart:developer';

import 'package:get/get.dart';
import 'package:sport_news/data/network_new/match_event.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';

class EventStatisticController extends GetxController {
  MatchEvent match;
  EventStatisticController({required this.match,});

  FirebaseManager firebaseManager = Get.find<FirebaseManager>();
  SharedPreferenceManager sharedPreferenceManager =
      Get.find<SharedPreferenceManager>();

  bool? likedByUser;

  @override
  void onInit() async {
    super.onInit();
    likedByUser = await sharedPreferenceManager.getLikeNews(match.snapshotId);
    update();
  }

  like() async {
    likedByUser = !likedByUser!;
    await sharedPreferenceManager.likeNews(match.snapshotId, likedByUser!);
    if (likedByUser!) {
      match.likeCount += 1;
    } else {
      match.likeCount -= 1;
    }

    await firebaseManager.updateMatchById(match: match);
    update();
    log('updated like=${likedByUser} in match = ${match.snapshotId} and count =${match.likeCount}');
  }
}
