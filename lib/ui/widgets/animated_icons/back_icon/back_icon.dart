import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import 'back_icon_controller.dart';

class BackIcon extends StatelessWidget {
  final BackIconController controller;
  BackIcon({required BackIconController this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BackIconController>(
      init: controller,
      builder: (_) => controller.riveArtboard == null
          ? const SizedBox()
          : Rive(artboard: controller.riveArtboard!),
    );
  }
}
