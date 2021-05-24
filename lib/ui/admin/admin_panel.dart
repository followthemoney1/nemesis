

import 'package:flutter/material.dart';

import 'admin_panel_controller.dart';
import 'create_new_team/create_new_team.dart';

class AdminPanel extends StatelessWidget {
  static final String page = "/admin";
  final controller = AdminPanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Flexible(child: CreateTeam())
      ],),
    );
  }


}