import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';
import 'dart:developer' as developer;
part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState(pointsValue: false));
  SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
  FirebaseManager firebaseManager = FirebaseManager();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    switch (event) {
      case SettingsEvent.init:
        final points = await sharedPreferenceManager.subscribedToNotification();

        if (points == null || points) {
          add(SettingsEvent.pointsOfNotification);
        } else {
          yield SettingsState(pointsValue: points);
        }
        developer.log(points.toString());
        //mark: test only data
        // final t = await firebaseManager.firebaseMessaging.getToken();
        // developer.log('token = ${t.toString()}');
        // firebaseManager.firebaseMessaging.onTokenRefresh.listen((event) {
        //   developer.log('token1 = ${event.toString()}');
        // });

        // firebaseManager.sendAndRetrieveMessage();

        // Timer.periodic(const Duration(minutes: 1), (c) {
        //   firebaseManager.sendAndRetrieveMessage();
        // });

        break;
      case SettingsEvent.pointsOfNotification:
        final points = !state.pointsValue;
        yield SettingsState(colorValue: state.colorValue, pointsValue: points);

        // final firebaseGroup = await firebaseManager.getFirebaseLangKeyByLang();
        // firebaseManager.subscribeMessaging(
        //     subscribe: points, topic: firebaseGroup.groupKey);
        await sharedPreferenceManager.subscribToNotification(points);

        break;
      case SettingsEvent.colorSelection:
        yield SettingsState(
            colorValue: !state.colorValue, pointsValue: state.pointsValue);
        break;
      case SettingsEvent.pickLightTheme:
        sharedPreferenceManager.pickLightTheme();
        break;
      case SettingsEvent.pickDarkTheme:
        sharedPreferenceManager.pickDarkTheme();
        break;
      case SettingsEvent.resetRecommendations:
        await clearRecommendation();
        yield ResetReccomendation();
        break;
      default:
        addError(Exception('unsupported event'));
    }
  }

  Future<bool> clearRecommendation() async {
    await sharedPreferenceManager.clearCategory();
    return true;
  }
}
