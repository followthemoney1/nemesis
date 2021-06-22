import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AnimatedElevationCardController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late Animation animationTween;
  String tag;
  AnimatedElevationCardController(this.tag);
  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animationTween = ColorTween(begin: Colors.transparent, end: Colors.red)
        .animate(animationController);
  }

  updateAnim({required bool selected}) {
    if (!selected) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    update();
  }
}

class AnimatedElevationCard extends StatelessWidget {
  Widget child;
  bool selected;
  
  AnimatedElevationCard({required this.child, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: selected ? Colors.red : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        child: child,
    );
  }

}
