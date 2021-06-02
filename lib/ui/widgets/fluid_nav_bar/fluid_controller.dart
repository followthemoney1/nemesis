import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/ui/header/header.dart';

class FluidController extends GetxController with SingleGetTickerProviderMixin{
  double nominalWidth = Header.topHeight;
  var widthChange = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  click() {
    widthChange = !widthChange;
    if (widthChange) {
      nominalWidth = Header.topHeight + 160;
    } else {
      nominalWidth = Header.topHeight;
    }
    update();

  }
}
