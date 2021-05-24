part of 'settings_bloc.dart';

class SettingsState {
  bool pointsValue;
  bool colorValue;

  SettingsState({this.colorValue = false, this.pointsValue = false});
}

class ResetReccomendation extends SettingsState {
  ResetReccomendation() : super(colorValue: false, pointsValue: false);
}
