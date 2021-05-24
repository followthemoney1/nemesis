import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sport_news/managers/campaign_manager.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState());
  CampaignManager campaignManager = CampaignManager();
//  final AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
//      afDevKey: "m22PfEswGsMx4jPry5djA9", showDebug: true, appId: "1523803009");

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event) {
      case HomeEvent.init:
        init();
        yield HomeState();
        break;
      default:
        addError(Exception('unsupported event'));
    }
  }

  init() async {
    campaignManager.getFbDeepLink();

    //  AppsflyerSdk appsFlyerSdk = AppsflyerSdk(appsFlyerOptions);
    //  appsFlyerSdk
    //      .initSdk(
    //          registerConversionDataCallback: true,
    //          registerOnAppOpenAttributionCallback: true)
    //      .then((value) {
    //    appsFlyerSdk.appOpenAttributionStream.listen((event) {
    //      //developer.log('value appOpenAttributionStream $event');
    //    });
    //    appsFlyerSdk.conversionDataStream.listen((event) {
    //      //developer.log('value conversionDataStream $event');
    //    });
    //  });
  }
}
