import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_news/managers/campaign_manager.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';
import 'package:sport_news/ui/header/header.dart';
import 'package:sport_news/ui/home/home_b/home_bloc.dart';
import 'package:sport_news/ui/news_detail/news_detail/news_detail_bloc.dart';
import 'package:sport_news/ui/news_detail/news_detail_page.dart';
import 'package:sport_news/ui/news_list/news_list_page.dart';
import 'package:sport_news/ui/recommendations/recommendations_page.dart';
import 'package:sport_news/ui/saved_news/saved_news_page.dart';
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
    NewsListPage(),
    SavedNewsPage(),
    RecommendationsPage(),
    SettingsPage()
  ];

  int _selectedMenuItem = 0;

  final StreamsChannel channel = new StreamsChannel('my_message_handler_ch');
  SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
  // GlobalKey mainWidgetKey = GlobalKey();
  @override
  void initState() {
    super.initState();

    // continuous stream of events from platform side, match some args
    channel.receiveBroadcastStream().listen((data) {
      developer.log(data.toString());

      // showToast(data.toString(),
      //     position: ToastPosition.bottom, duration: const Duration(seconds: 2));

      _handleNotificationClick(data);
    });
    // if (Platform.isAndroid || Platform.isIOS) {
    //   FirebaseManager().firebaseMessaging.configure(
    //         onMessage: (Map<String, dynamic> message) async {},
    //         onBackgroundMessage: myBackgroundMessageHandler,
    //         onLaunch: (Map<String, dynamic> message) async {
    //           final d = message["data"];
    //           final data = d["id"];
    //           developer.log(data.toString());
    //           // showToast(message.toString(),
    //           //     position: ToastPosition.bottom,
    //           //     duration: const Duration(seconds: 2));
    //           _handleNotificationClick(data);
    //         },
    //         onResume: (Map<String, dynamic> message) async {
    //           final d = message["data"];
    //           final data = d["id"];
    //           developer.log(data.toString());
    //           // showToast(message.toString(),
    //           //     position: ToastPosition.bottom,
    //           //     duration: const Duration(seconds: 2));
    //           _handleNotificationClick(data);
    //         },
    //       );
    // }
  }

  _handleNotificationClick(String id) {
    // FirebaseManager().getOneNewsByNewsKey(id.toString()).then((news) {
    //   if (news != null && news.heroName != null && news.heroName.isNotEmpty) {
    //     Future.delayed(const Duration(seconds: 1), () async {
    //       await CampaignManager().updateViewCount(firebaseNews: news);
    //       Navigator.of(context).push<void>(
    //         NewsDetailPage.route(
    //           context,
    //           mainWidgetKey,
    //           args: news,
    //         ),
    //       );
    //     });
    //   }
    // });
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
      body: BlocListener<HomeBloc, HomeState>(
        bloc: BlocProvider.of<HomeBloc>(context)..add(HomeEvent.init),
        listener: (_, state) {},
        child: Header(
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
      ),
    );
  }
}
