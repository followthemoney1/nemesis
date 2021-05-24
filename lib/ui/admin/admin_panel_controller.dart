


import 'package:bloc/bloc.dart';
import 'package:sport_news/managers/firebase_manager.dart';

class AdminPanelController extends Cubit{
  // var count = 0.obs;
  // increment() => count++;
  FirebaseManager firebase = FirebaseManager();

  AdminPanelController() : super(null){
    //init auth
  }


}