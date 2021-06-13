import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rive/rive.dart';

class MenuIconController extends GetxController {
  Artboard? riveArtboard;

  SimpleAnimation close = SimpleAnimation('close');
  SimpleAnimation open = SimpleAnimation('open');
  @override
  void onInit() {
    super.onInit();
    rootBundle.load('assets/animations/menu.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        
        artboard.addController(open);
        artboard.addController(close);
        close.isActive = false;
        open.isActive = false;

        riveArtboard = artboard;

        update();
      },
    );
  }

  toggle(bool toggle) {
    if (!toggle) {
      close.isActive = true;
    } else {
      open.isActive = true;
    }

    log('menu toggle');
  }
}
