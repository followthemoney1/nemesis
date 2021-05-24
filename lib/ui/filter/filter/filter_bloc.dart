import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sport_news/data/network/categories.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'dart:developer' as developer;

part 'filter_event.dart';

part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc()
      : super(FilterState(
            allCategories: [], selectedCategories: [], appliedFilter: false));

  FirebaseManager firebaseManager = FirebaseManager();
  List<FirebaseCategories> _allCategories = [];
  List<FirebaseCategories> _selectedCategories = [];
  bool _applyFilter = false;

  List<FirebaseCategories> get allCategories => _allCategories;

  List<FirebaseCategories> get selectedCategories => _selectedCategories;

  @override
  Stream<FilterState> mapEventToState(FilterEvent event) async* {
    switch (event) {
      case FilterEvent.init:
        getCategories();
        break;
      case FilterEvent.update:
        yield FilterState(
            allCategories: _allCategories,
            selectedCategories: _selectedCategories,
            appliedFilter: _applyFilter);
        break;
      case FilterEvent.applyFilter:
        _applyFilter = true;
        break;
      default:
        addError(Exception('unsupported event'));
    }
  }

  getCategories() async {
    // if (!_applyFilter) {
    //   _selectedCategories.clear();
    //   add(FilterEvent.update);
    //   await firebaseManager.getFirebaseCategory(
    //       onDone: (List<FirebaseCategories> data) {
    //     _allCategories.clear();
    //     _allCategories.addAll(data);
    //     add(FilterEvent.update);
    //   });
    // }
  }

  void pickCategory(FirebaseCategories category, bool selected) {
    if (!selected) {
      _selectedCategories.add(category);
    } else {
      _selectedCategories
          .removeWhere((element) => element.title == category.title);
    }
    developer
        .log('selected category = ${_selectedCategories.length.toString()}');
    add(FilterEvent.update);
  }
}
