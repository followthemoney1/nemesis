import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sport_news/data/network/categories.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';
import 'package:sport_news/ui/widgets/staggered_user_suggestion.dart';

part 'user_suggestion_event.dart';
part 'user_suggestion_state.dart';

class UserSuggestionBloc
    extends Bloc<UserSuggestionEvent, UserSuggestionState> {
  UserSuggestionBloc() : super(UserSuggestionState());
  FirebaseManager _firebaseManager = FirebaseManager();
  SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
  List<FirebaseCategories> _categories = [];

  @override
  Stream<UserSuggestionState> mapEventToState(
      UserSuggestionEvent event) async* {
    switch (event) {
      case UserSuggestionEvent.init:
        getGroups();
        break;
      case UserSuggestionEvent.update:
        yield UserSuggestionState(categories: _categories);
        break;
      default:
        addError(Exception('unsupported event'));
    }
  }

  getGroups() async {
    // await _firebaseManager.getFirebaseCategory(
    //     onDone: (List<FirebaseCategories> data) {
    //   _categories.clear();
    //   _categories.addAll(data);
    //   add(UserSuggestionEvent.update);
    // });
  }

  updateCategory(SuggestionItem i) async {
    if (i.selected || i.superLike) {
      await sharedPreferenceManager.saveCategory(i.data!.key!);
    } else {
      await sharedPreferenceManager.deleteCategory(i.data!.key);
    }
  }
}
