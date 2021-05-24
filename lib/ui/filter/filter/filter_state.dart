part of 'filter_bloc.dart';

class FilterState {
  List<FirebaseCategories> allCategories;
  List<FirebaseCategories> selectedCategories;
  bool appliedFilter;

  FilterState({this.allCategories, this.selectedCategories, this.appliedFilter});
}
