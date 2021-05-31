import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:sport_news/managers/campaign_manager.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';
import 'package:sport_news/ui/header/header.dart';
import 'package:sport_news/ui/home/home_b/home_bloc.dart';
import 'package:sport_news/ui/news_detail/news_detail/news_detail_bloc.dart';
import 'package:sport_news/ui/news_detail/news_detail_page.dart';
import 'package:sport_news/ui/news_list/news_list_page.dart';

import 'package:sport_news/ui/settings/settings_page.dart';
import 'package:sport_news/ui/user_suggestion/user_suggestion.dart';
import 'package:sport_news/ui/widgets/fluid_nav_bar/fluid_nav_bar.dart';
import 'package:streams_channel/streams_channel.dart';
import 'dart:developer' as developer;

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  developer.log(message.toString());
  final data = message["data"];
  developer.log(data.toString());
  return Future<void>.value();
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  static final tag = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<Widget> _menuWidgets = <Widget>[
    MatchesListPage(),
    // SavedNewsPage(),
    // RecommendationsPage(),
    // SettingsPage()
  ];

  int _selectedMenuItem = 0;

  SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
  // GlobalKey mainWidgetKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    //mark: check recommended is non null
    if (index == 2) {
      SharedPreferenceManager().getCategoryList().then((value) {
        if (value == null || value.length < 1) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(UserSuggestion.tag, (route) => false);
        }
      });
    }
    setState(() {
      _selectedMenuItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Header(
        child: Center(
          // key: mainWidgetKey,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: FluidNavBar.nominalWidth,
                right: 0,
                child: SafeArea(
                  top: true,
                  bottom: false,
                  child: IndexedStack(
                      index: _selectedMenuItem, children: _menuWidgets),
                ),
              ),
              Positioned(
                bottom: 0,
                top: 0,
                left: 0,
                //right: 0,
                child: FluidNavBar(onChange: _onItemTapped),
              )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: FluidNavBar(onChange: _onItemTapped),
    );
  }
}
