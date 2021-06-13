import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rive/rive.dart';

class BackIconController extends GetxController {
  Artboard? riveArtboard;
  SimpleAnimation unselected = SimpleAnimation('unselected');
  // late SimpleAnimation selected;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    rootBundle.load('assets/animations/back.riv').then(
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
       
        artboard.addController(unselected);
        unselected.isActive = false;
        // artboard.addController(selected);

        riveArtboard = artboard;

        update();
      },
    );
  }

  toggle(bool hover) {
    if (hover) {
      // selected.isActive = true;
      unselected.isActive = true;
    } else {
    //  selected.isActive = false;
      unselected.isActive = false;
    }

    log('menu toggle');
  }
}
