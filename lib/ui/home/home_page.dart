import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_news/constants.dart';
import 'package:sport_news/managers/campaign_manager.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';
import 'package:sport_news/ui/header/header.dart';
import 'package:sport_news/ui/home/home_controller.dart';

import 'package:sport_news/ui/news_list/news_list_page.dart';

import 'package:sport_news/ui/settings/settings_page.dart';
import 'package:sport_news/ui/user_suggestion/user_suggestion.dart';
import 'package:sport_news/ui/widgets/fluid_nav_bar/fluid_nav_bar.dart';
import 'dart:developer' as developer;

import 'package:sport_news/ui/widgets/twitch/twitch_player.dart';

class HomePage extends GetView<HomeController> {
  static final page = '/home';

  HomePage({Key? key}) : super(key: key);

  static final List<Widget> _menuWidgets = <Widget>[
    Container(height: 400,width: 800,),
    MatchesListPage(tag: TeamsCategoryConstants.DOTA2,),
    MatchesListPage(tag: TeamsCategoryConstants.CSGO,),
    MatchesListPage(tag: TeamsCategoryConstants.LEAGUE_OF_LEGENDS,),
    // SavedNewsPage(),
    // RecommendationsPage(),
    // SettingsPage()
  ];

  // GlobalKey mainWidgetKey = GlobalKey();

  void onItemTapped(int index) {
    //mark: check recommended is non null
    controller.selectedMenuPage = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: controller,
        builder: (_) => Center(
            // key: mainWidgetKey,
            child: Stack(
          children: [
            Positioned(
              top: Header.topHeight,
              bottom: 0,
              left: Header.topHeight,
              right: 0,
              child: SafeArea(
                top: true,
                bottom: false,
                child: IndexedStack(
                    index: controller.selectedMenuPage, children: _menuWidgets),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Header(),
            ),
            Positioned(
              bottom: 0,
              top: 0,
              left: 0,
              //right: 0,
              child: FluidNavBar(
                  selectedIndex: controller.selectedMenuPage,
                  onChange: onItemTapped),
            )
          ],
        )),
      ),
    );
  }
}
