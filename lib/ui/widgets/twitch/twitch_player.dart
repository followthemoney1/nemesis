import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/material.dart';
// import 'package:webviewx/webviewx.dart';
import 'dart:ui' as ui;

import 'package:webviewx/webviewx.dart';
// import 'package:flutter_web_ui/ui.dart' as ui;

class TwitchPlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TwitchPlayerState();
  }
}

class TwitchPlayerState extends State {
  //https://player.twitch.tv/?channel=icebergdoto&muted=true&parent=nemesis.app

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebViewX(
        initialContent:
            """<script src= "https://player.twitch.tv/js/embed/v1.js"></script>
                  <div id="${345}"></div>
                  <script type="text/javascript">
                  var options = {
                      width: "${300}",
                      height: "${300}",
                      channel: "icebergdoto",
                      parent: ["nemesis.app",]
                    };
                    var player = new Twitch.Player("345", options);
                    player.setVolume(0.5);
                  </script>""",
        initialSourceType: SourceType.HTML,
        onWebViewCreated: (controller) {});
    ;
  }
}
