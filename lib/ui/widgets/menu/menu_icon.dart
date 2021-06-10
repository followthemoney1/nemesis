import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import 'menu_icon_controller.dart';


class MenuIcon extends StatelessWidget {
  final MenuIconController controller;
  MenuIcon({required MenuIconController this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuIconController>(init:controller,builder:(_)=>controller.riveArtboard == null
            ? const SizedBox()
            : Rive(artboard: controller.riveArtboard!),
      
    );
  }

 
}
