import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rive/rive.dart';

class MenuIconController extends GetxController {
  Artboard? riveArtboard;
 

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    rootBundle.load('assets/animations/menu.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        // Add a controller to play back a known animation on the main/default
        // artboard.We store a reference to it so we can toggle playback.
        // artboard.addController(closeController = SimpleAnimation('close'));
        // artboard.addController(openController = SimpleAnimation('open'));

        riveArtboard = artboard;

        update();
      },
    );
  }

  toggle(bool open) {
    if (!open) {
      riveArtboard!.addController(SimpleAnimation('close'));
    } else {
            riveArtboard!.addController(SimpleAnimation('open'));
    }

    log('menu toggle');
  }
}
