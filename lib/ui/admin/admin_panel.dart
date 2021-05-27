import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sport_news/ui/admin/create_new_team/create_team_controller.dart';

import 'admin_panel_controller.dart';
import 'create_new_team/create_new_team.dart';

class AdminPanel extends GetView<AdminPanelController> {
  static final String page = "/admin";

  @override
  Widget build(BuildContext context) {
    AutoSizeText()
    return Scaffold(
        body: Row(
          children: [
            Flexible(
                child: CreateTeam(
              tag: "firstT",
            )),
            Flexible(
                child: CreateTeam(
              tag: "secondT",
            ))
          ],
        ),
      
    );
  }
}
