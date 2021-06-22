
import 'dart:developer';
import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:sport_news/constants.dart';
import 'package:sport_news/ui/admin/create_category/create_category_controller.dart';
import 'package:sport_news/ui/home/home_controller.dart';
import 'package:sport_news/ui/news_list/news_list_controller.dart';
import 'package:sport_news/ui/widgets/animated_elevation_card.dart';
import 'package:sport_news/ui/widgets/fluid_nav_bar/fluid_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<FluidController>(FluidController());
    Get.lazyPut<MatchesListController>(() => MatchesListController(tag: TeamsCategoryConstants.CSGO),tag: TeamsCategoryConstants.CSGO);
    Get.lazyPut<MatchesListController>(() => MatchesListController(tag: TeamsCategoryConstants.DOTA2),tag: TeamsCategoryConstants.DOTA2);
    Get.lazyPut<MatchesListController>(() => MatchesListController(tag: TeamsCategoryConstants.LEAGUE_OF_LEGENDS),tag: TeamsCategoryConstants.LEAGUE_OF_LEGENDS);
    // Get.lazyPut<AnimatedElevationCardController>(() => AnimatedElevationCardController(math.Random().nextInt(1000).toString()));
    log("root binding");
  }
}
