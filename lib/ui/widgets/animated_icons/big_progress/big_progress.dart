


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class BigProgress extends StatefulWidget {
 

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return BigProgressState();
  }
}

class BigProgressState extends State{

    Artboard? riveArtboard;

@override
void initState() { 
  super.initState();
  rootBundle.load('assets/animations/zombie_character.riv').then(
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
       
        artboard.addController(SimpleAnimation('Walk'));
       
        // artboard.addController(selected);
        setState(() {
           riveArtboard = artboard;
        });
       

       
      },
    );
}
    @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(widthFactor: 0.2,child: riveArtboard!=null ? Rive(artboard: riveArtboard!) : Container());
        
  }

}