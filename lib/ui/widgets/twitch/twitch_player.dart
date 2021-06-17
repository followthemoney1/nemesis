import 'dart:async';
import 'dart:html' as html;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:measured_size/measured_size.dart';
// import 'package:webviewx/webviewx.dart';
import 'dart:ui' as ui;

import 'package:webviewx/webviewx.dart';
// import 'package:flutter_web_ui/ui.dart' as ui;

class TwitchPlayer extends StatefulWidget {
  final divId = Random().nextInt(300);

  final streamName;
  TwitchPlayer({
    required this.streamName,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TwitchPlayerState();
  }
}

class TwitchPlayerState extends State<TwitchPlayer> {
  WebViewXController? controller;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
      Size playerSize = Size(
        constraints.maxWidth,
        constraints.maxHeight,
      );

      print('sized changed = ${playerSize.width}');

      var loadData =
          """<script src= "https://player.twitch.tv/js/embed/v1.js"></script>
                  <div id="${widget.divId}"></div>
                  <script type="text/javascript">
                  var options = {
                      width: "${playerSize!.width}",
                      height: "${playerSize!.height}",
                      channel: "${widget.streamName}",
                      parent: ["nemesis.app",]
                    };
                    var player = new Twitch.Player("${widget.divId}", options);
                    player.setVolume(0.5);
                  </script>""";
                  
      if (controller != null) {
        controller!.reload();
        controller!.loadContent(loadData, SourceType.HTML);
      }
      return playerSize.width <= 0
          ? Container()
          : Container(
              width: playerSize!.width,
              height: playerSize!.height,
              child: WebViewX(onWebViewCreated: (controller) {
                this.controller = controller;
              }),
            );
    });
  }
}
